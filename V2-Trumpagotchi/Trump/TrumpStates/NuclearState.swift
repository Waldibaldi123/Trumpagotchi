//
//  NuclearState.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/17/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class NuclearState: GKState {
    var officeScene: OfficeScene!
    var trump: Trump!
    let sleepPoint: CGPoint
        
    init(scene: OfficeScene, trump: Trump) {
        self.officeScene = scene
        self.trump = trump
        self.sleepPoint = CGPoint(x: officeScene.size.width * relativeSleepPoint.x, y: officeScene.size.height * relativeSleepPoint.y)
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    override func didEnter(from previousState: GKState?) {
        trump.run(trump.walk(dest: sleepPoint))
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if !trump.hasActions() {
            trump.run(SKAction.scaleX(to: 1.4, duration: 0.01))
            trump.run(SKAction.scaleY(to: 1.15, duration: 0.01))
            trump.run(trump.nuclearState())
        }
    }
    
    override func willExit(to nextState: GKState) {
        trump.removeAllActions()
        trump.setScale(1.0)
    }
}

