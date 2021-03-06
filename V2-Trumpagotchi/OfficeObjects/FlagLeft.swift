//
//  FlagLeft.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/29/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class FlagLeft: SKSpriteNode {
    
    init(screenSize: CGSize) {
        let texture = SKTexture(imageNamed: "flagLeft")
        let scaleRatio = (screenSize.width / scaleToScreenDict["flagLeft"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["flagLeft"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        self.position = CGPoint(x: relativePosDict[screenRatio]!["flagLeft"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["flagLeft"]!.y * screenSize.height)
        self.zPosition = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
