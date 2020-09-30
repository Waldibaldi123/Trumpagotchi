//
//  DictatorState.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/29/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class DictatorState: GKState {
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
        trump.run(SKAction.sequence([trump.smile(), trump.typeTweet()]))
        
        for i in 0..<200 {
            let tweet = TweetPile(screenSize: officeScene.size, startPos: CGPoint(x: 0, y: 0), endPos: getRandomTweetPoint(), officeScene: officeScene)
            Timer.scheduledTimer(withTimeInterval: 3 + Double(i) / 200, repeats: false) {_ in
                self.officeScene.addChild(tweet)
            }
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
    
    override func willExit(to nextState: GKState) {
        
    }
    
    func getRandomTweetPoint() -> CGPoint {
        let randX = CGFloat(arc4random() % UInt32(officeScene.size.width))
        let randY = CGFloat(arc4random() % UInt32(officeScene.size.height))
        return CGPoint(x: randX, y: randY)
    }
}
