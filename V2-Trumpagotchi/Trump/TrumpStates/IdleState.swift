//
//  IdleState.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/4/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class IdleState: GKState {
    var officeScene: OfficeScene!
    var trump: Trump!
    var isWatchingTV = false
    
    //idle timers
    var idleWalkTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {timer in timer.invalidate()}
    var tweetTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {timer in timer.invalidate()}
    var shrugTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in timer.invalidate()}
    var drinkTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in timer.invalidate()}
    
    init(scene: OfficeScene, trump: Trump) {
        self.officeScene = scene
        self.trump = trump
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    override func didEnter(from previousState: GKState?) {
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        updateTimers()
        
        if trump.tiredMeter > 75 {
            trump.texture = SKTexture(imageNamed: "trump-tired")
        } else {
            trump.texture = SKTexture(imageNamed: "trump-standing")
        }
        
        if !trump.hasActions() && officeScene.television.isOn {
            if trump.tiredMeter > 50 {
                self.stateMachine?.enter(SleepState.self)
            } else {
                self.stateMachine?.enter(WatchTVState.self)
            }
        }
    }
    
    override func willExit(to nextState: GKState) {
        idleWalkTimer.invalidate()
        tweetTimer.invalidate()
        shrugTimer.invalidate()
        drinkTimer.invalidate()
        
        trump.removeAllActions()
    }
    
    func updateTimers() {
        if !idleWalkTimer.isValid {
            idleWalkTimer = Timer.scheduledTimer(withTimeInterval: randomIdleWalkInterval, repeats: false) {  timer in
                if self.stateMachine?.currentState is IdleState && !self.trump.hasActions() {
                    let dest = self.officeScene.pathFinder.getRandomWalkablePoint()
                    self.trump.run(self.trump.walk(dest: dest))
                }
                timer.invalidate()
            }
        }
        
        if !tweetTimer.isValid {
            tweetTimer = Timer.scheduledTimer(withTimeInterval: randomTweetInterval, repeats: false) {  timer in
                if !self.trump.hasActions() {
                    self.trump.run(self.trump.typeTweet())
                }
                timer.invalidate()
            }
        }
        
        if !shrugTimer.isValid {
            shrugTimer = Timer.scheduledTimer(withTimeInterval: randomShrugInterval, repeats: false) {  timer in
                if !self.trump.hasActions() {
                    self.trump.run(self.trump.shrug())
                }
                timer.invalidate()
            }
        }
        
        if !drinkTimer.isValid {
            drinkTimer = Timer.scheduledTimer(withTimeInterval: randomDrinkInterval, repeats: false) {  timer in
                if !self.trump.hasActions() {
                    self.stateMachine?.enter(CokeState.self)
                }
                timer.invalidate()
            }
        }
    }
}
