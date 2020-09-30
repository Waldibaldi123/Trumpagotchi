//
//  Curtain.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/29/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class Curtain: SKSpriteNode {
    
    init(screenSize: CGSize) {
        let texture = SKTexture(imageNamed: "curtain")
        let scaleRatio = (screenSize.width / scaleToScreenDict["curtain"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["curtain"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.anchorPoint = CGPoint(x: 0.5, y: 1)
        self.position = CGPoint(x: relativePosDict[screenRatio]!["curtain"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["curtain"]!.y * screenSize.height)
        self.zPosition = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
