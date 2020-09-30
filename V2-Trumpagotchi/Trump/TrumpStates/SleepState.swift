//
//  SleepState.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/4/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class SleepState: GKState {
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
            trump.size = trump.newSize(currentY: trump.position.y)
            trump.run(SKAction.scaleX(to: 1.3, duration: 0.01))
            trump.run(SKAction.scaleY(to: 0.8, duration: 0.01))
            trump.run(trump.sleep())
        }
        
        if !officeScene.television.isOn && positionsEqual(pos1: trump.position, pos2: sleepPoint) {
            self.stateMachine?.enter(LazyState.self)
        } else if !officeScene.television.isOn {
            self.stateMachine?.enter(IdleState.self)
        }
        
        if trump.tiredMeter == 0 {
            self.stateMachine?.enter(LazyState.self)
        }
    }
    
    override func willExit(to nextState: GKState) {
        trump.removeAllActions()
        trump.setScale(1.0)
    }
}
