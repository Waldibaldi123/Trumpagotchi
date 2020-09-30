//
//  WatchTVState.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/4/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class WatchTVState: GKState {
    var officeScene: OfficeScene!
    var trump: Trump!
    var isWatchingTV = false
    let sleepPoint: CGPoint
    
    var tweetTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in timer.invalidate()}
    var drinkTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in timer.invalidate()}
    
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
        trump.texture = SKTexture(imageNamed: "trump-back")
        trump.run(trump.walk(dest: sleepPoint))
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        updateTimers()
        if !officeScene.television.isOn {
            self.stateMachine?.enter(IdleState.self)
        }
    }
    
    override func willExit(to nextState: GKState) {
        trump.texture = SKTexture(imageNamed: "trump-standing")
    }
    
    func updateTimers() {
        if !tweetTimer.isValid {
            tweetTimer = Timer.scheduledTimer(withTimeInterval: randomTweetInterval, repeats: false) {  timer in
                if !self.trump.hasActions() {
                    self.trump.run(self.trump.typeTweet())
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
