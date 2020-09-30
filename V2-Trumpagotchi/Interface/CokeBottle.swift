//
//  CokeBottle.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/30/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class CokeBottle: SKSpriteNode {
    var isMoving = false
    
    init(screenSize: CGSize) {
        let texture = SKTexture(imageNamed: "cokeBottle")
        let scaleRatio = (screenSize.width / scaleToScreenDict["cokeBottle"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["cokeBottle"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.position = CGPoint(x: relativePosDict[screenRatio]!["cokeBottle"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["cokeBottle"]!.y * screenSize.height)
        self.zPosition = 100
        self.isHidden = true
    }
    
    func resetPosition(screenSize: CGSize) {
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        let position = CGPoint(x: relativePosDict[screenRatio]!["cokeBottle"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["cokeBottle"]!.y * screenSize.height)
        self.run(SKAction.move(to: position, duration: 0.01))
        isMoving = false
    }
    
    func moveToResetPosition(screenSize: CGSize) {
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        let position = CGPoint(x: relativePosDict[screenRatio]!["cokeBottle"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["cokeBottle"]!.y * screenSize.height)
        self.run(SKAction.move(to: position, duration: 0.2))
        isMoving = false
    }
    
    func moveTo(location: CGPoint) {
        self.run(SKAction.move(to: location, duration: 0.01))
        isMoving = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
