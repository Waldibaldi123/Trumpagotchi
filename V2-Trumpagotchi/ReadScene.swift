//
//  ReadScene.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/30/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

class ReadScene: SKScene {
    let briefing = SKSpriteNode(texture: SKTexture(imageNamed: "briefing"))
    let pointer = SKSpriteNode(texture: SKTexture(imageNamed: "pointerArrow"))
    let phoneHand = SKSpriteNode(texture: SKTexture(imageNamed: "phoneHand"))
    var touchCount = 0
    var lastTouchTime = CFAbsoluteTimeGetCurrent()
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        briefing.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        pointer.anchorPoint = CGPoint(x: 0.5, y: 1)
        pointer.setScale(0.2)
        pointer.zPosition = 1
        pointer.position = CGPoint(x: -briefing.size.width/2, y: briefing.size.height/2)
        
        phoneHand.anchorPoint = CGPoint(x: 0.5, y: 1)
        phoneHand.setScale(1)
        phoneHand.zPosition = 1
        phoneHand.position = CGPoint(x: self.size.width - 100, y: 0)
        
        addChild(briefing)
        briefing.addChild(pointer)
        addChild(phoneHand)
    }
    
    override func update(_ currentTime: TimeInterval) {
        let currentTime = CFAbsoluteTimeGetCurrent()
        
        if(currentTime - lastTouchTime > 0.5) {
            let dest = CGPoint(x: phoneHand.position.x, y: phoneHand.size.height)
            phoneHand.run(SKAction.move(to: dest, duration: 1))
        } else {
            phoneHand.removeAllActions()
            phoneHand.position = CGPoint(x: self.size.width - 100, y: 0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            lastTouchTime = CFAbsoluteTimeGetCurrent()
            touchCount += 1
            var destX : CGFloat
            var destY : CGFloat
            
            if(touchCount % (touchMax / amountLines) == 0) {
                destX = -briefing.size.width / 2
                destY = pointer.position.y - (briefing.size.height / CGFloat(amountLines))
            } else {
                destX = pointer.position.x + briefing.size.width / CGFloat((touchMax / amountLines))
                destY = pointer.position.y
            }
            pointer.removeAllActions()
            pointer.run(SKAction.move(to: CGPoint(x: destX, y: destY), duration: 0.1))
            
            if(touchCount >= touchMax) {
                let officeScene = OfficeScene(size: (self.view?.bounds.size)!)
                officeScene.readSceneSuccess = true
                self.view?.presentScene(officeScene)
            }
        }
    }
}
