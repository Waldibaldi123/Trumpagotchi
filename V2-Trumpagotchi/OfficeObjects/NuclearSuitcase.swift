//
//  NuclearSuitcase.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/16/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class NuclearSuitcase: SKSpriteNode {
    var screenSize: CGSize
    var isOpen = false
    
    init(screenSize: CGSize) {
        self.screenSize = screenSize
        let texture = SKTexture(imageNamed: "nuclearSuitcase-closed")
        let scaleRatio = (screenSize.width / scaleToScreenDict["nuclearSuitcase"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["nuclearSuitcase"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.position = CGPoint(x: relativePosDict[screenRatio]!["nuclearSuitcase"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["nuclearSuitcase"]!.y * screenSize.height)
        self.zPosition = 6
        self.isUserInteractionEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isOpen.toggle()
        if isOpen {
            self.texture = SKTexture(imageNamed: "nuclearSuitcase-open")
        } else {
            self.texture = SKTexture(imageNamed: "nuclearSuitcase-closed")
        }
    }
    
    func activate() {
        self.position = CGPoint(x: screenSize.width * relativeSleepPoint.x, y: screenSize.height * relativeSleepPoint.y)
        self.setScale(1.5)
    }
    
    func deactivate() {
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.position = CGPoint(x: relativePosDict[screenRatio]!["nuclearSuitcase"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["nuclearSuitcase"]!.y * screenSize.height)
        self.setScale(1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
