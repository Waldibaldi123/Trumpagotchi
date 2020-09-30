//
//  LazyState.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/5/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class LazyState: GKState {
    var officeScene: OfficeScene!
    var trump: Trump!
        
    init(scene: OfficeScene, trump: Trump) {
        self.officeScene = scene
        self.trump = trump
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    override func didEnter(from previousState: GKState?) {
        trump.run(trump.lazy())
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        trump.run(SKAction.scaleX(to: 1.3, duration: 0.01))
        trump.run(SKAction.scaleY(to: 0.8, duration: 0.01))
    }
    
    override func willExit(to nextState: GKState) {
        trump.removeAllActions()
        trump.setScale(1.0)
        trump.run(trump.touched())
    }
}
