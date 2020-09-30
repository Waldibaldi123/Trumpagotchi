//
//  SmallTable.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/29/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class SmallTable: SKSpriteNode {
    
    init(screenSize: CGSize) {
        let texture = SKTexture(imageNamed: "smallTable")
        let scaleRatio = (screenSize.width / scaleToScreenDict["smallTable"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["smallTable"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.position = CGPoint(x: relativePosDict[screenRatio]!["smallTable"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["smallTable"]!.y * screenSize.height)
        self.zPosition = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
