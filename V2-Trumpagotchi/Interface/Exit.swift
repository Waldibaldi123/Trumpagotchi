//
//  Exit.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/30/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class Exit: SKSpriteNode {
    let officeScene: OfficeScene
    
    init(officeScene: OfficeScene) {
        self.officeScene = officeScene
        let texture = SKTexture(imageNamed: "exit")
        let scaleRatio = (officeScene.size.width / scaleToScreenDict["exit"]!) / texture.size().width
        let spriteSize = CGSize(width: officeScene.size.width / scaleToScreenDict["exit"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (officeScene.size.height / officeScene.size.width)) / 100))
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.position = CGPoint(x: relativePosDict[screenRatio]!["exit"]!.x * officeScene.size.width, y: relativePosDict[screenRatio]!["exit"]!.y * officeScene.size.height)
        self.zPosition = 10
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if officeScene.television.isOn {
            if officeScene.trump.stateMachine.currentState is WatchTVState {
                officeScene.trump.run(officeScene.trump.shrug())
            } else if officeScene.trump.stateMachine.currentState is NuclearState {
                officeScene.transitionToMinigame()
            }
        } else if officeScene.trump.tiredMeter != 100 || officeScene.trump.stateMachine.currentState is NuclearState {
            officeScene.transitionToMinigame()
        } else if officeScene.trump.stateMachine.currentState is IdleState {
            officeScene.trump.removeAllActions()
            officeScene.trump.run(officeScene.trump.yawn())
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
