//
//  CokeButton.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/29/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class CokeButton: SKSpriteNode {
    var officeScene: OfficeScene!
    
    init(screenSize: CGSize, officeScene: OfficeScene) {
        self.officeScene = officeScene
        
        let texture = SKTexture(imageNamed: "cokeButton")
        let scaleRatio = (screenSize.width / scaleToScreenDict["cokeButton"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["cokeButton"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.position = CGPoint(x: relativePosDict[screenRatio]!["cokeButton"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["cokeButton"]!.y * screenSize.height)
        self.zPosition = 21
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        officeScene.devAvatar.showAvatar(title: cokeButtonComment["title"] ?? "", source: cokeButtonComment["source"] ?? "", text: cokeButtonComment["text"] ?? "", texture: self.texture!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
