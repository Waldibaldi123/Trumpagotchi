//
//  Trophy.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 9/3/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class Trophy: SKSpriteNode {
    var officeScene: OfficeScene!
    
    init(screenSize: CGSize, officeScene: OfficeScene) {
        self.officeScene = officeScene
        
        let texture = SKTexture(imageNamed: "trophy")
        let scaleRatio = (screenSize.width / scaleToScreenDict["trophy"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["trophy"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        self.position = CGPoint(x: relativePosDict[screenRatio]!["trophy"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["trophy"]!.y * screenSize.height)
        self.zPosition = 21
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        officeScene.devAvatar.showAvatar(title: trophyComment["title"] ?? "", source: trophyComment["source"] ?? "", text: trophyComment["text"] ?? "", texture: self.texture!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
