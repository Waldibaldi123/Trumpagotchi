//
//  TrashBin.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/23/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class TrashBin: SKSpriteNode {

    init(screenSize: CGSize) {
        let texture = SKTexture(imageNamed: "trashBin")
        let scaleRatio = (screenSize.width / scaleToScreenDict["trashBin"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["trashBin"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        self.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        self.position = CGPoint(x: screenSize.width - 10, y: 10)
        
        self.zPosition = 3
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
