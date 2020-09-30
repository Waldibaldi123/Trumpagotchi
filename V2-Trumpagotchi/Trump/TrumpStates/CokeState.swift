//
//  CokeState.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/4/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class CokeState: GKState {
    var officeScene: OfficeScene!
    var trump: Trump!
    var allActionsPerformed = false
    var prevStateWasWatchTVState = false
    
    init(scene: OfficeScene, trump: Trump) {
        self.officeScene = scene
        self.trump = trump
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    override func didEnter(from previousState: GKState?) {
        if previousState is WatchTVState {
            prevStateWasWatchTVState = true
        }
        
        allActionsPerformed = false
        let cokePoint = CGPoint(x: officeScene.size.width * relativeCokePoint.x, y: officeScene.size.height * relativeCokePoint.y)
        let cokeAction = SKAction.sequence([trump.walk(dest: cokePoint), trump.pressButton()])
        trump.run(cokeAction)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if !trump.hasActions() {
            if allActionsPerformed {
                if prevStateWasWatchTVState {
                    self.stateMachine?.enter(WatchTVState.self)
                } else {
                    self.stateMachine?.enter(IdleState.self)
                }
            } else {
                if officeScene.desk.cokeAmount > 0 {
                    officeScene.desk.changeCokeAmount(value: -1)
                    trump.run(trump.drink())
                    allActionsPerformed = true
                } else {
                    trump.run(SKAction.sequence([trump.stomp(), trump.pressButton()]))
                }
            }
        }
    }
    
    override func willExit(to nextState: GKState) {
        
    }
}

