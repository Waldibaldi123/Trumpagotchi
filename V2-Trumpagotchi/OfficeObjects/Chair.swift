//
//  Chair.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/29/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class Chair: SKSpriteNode {
    
    init(screenSize: CGSize) {
        let texture = SKTexture(imageNamed: "chair")
        let scaleRatio = (screenSize.width / scaleToScreenDict["chair"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["chair"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.position = CGPoint(x: relativePosDict[screenRatio]!["chair"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["chair"]!.y * screenSize.height)
        self.zPosition = 19
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
