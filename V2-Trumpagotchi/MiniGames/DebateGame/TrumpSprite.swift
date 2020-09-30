//
//  TrumpSprite.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/6/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class TrumpSprite: SKSpriteNode {
    init(screenSize: CGSize) {
        let texture = SKTexture(imageNamed: "trumpPodium")
        let scaleRatio = (screenSize.width * 0.3) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width * 0.3, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        self.anchorPoint = CGPoint(x: 0, y: 0.0)
        self.position = CGPoint(x: 10, y: screenSize.height * 0.5)
        self.alpha = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
