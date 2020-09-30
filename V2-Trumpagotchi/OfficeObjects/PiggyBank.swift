//
//  PiggyBank.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 9/9/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class PiggyBank: SKSpriteNode {
    var officeScene: OfficeScene!
    
    init(screenSize: CGSize, officeScene: OfficeScene) {
        self.officeScene = officeScene
        
        let texture = SKTexture(imageNamed: "piggyBank")
        let scaleRatio = (screenSize.width / scaleToScreenDict["piggyBank"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["piggyBank"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        self.position = CGPoint(x: relativePosDict[screenRatio]!["piggyBank"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["piggyBank"]!.y * screenSize.height)
        self.zPosition = 21
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
