//
//  BriefingScene.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/16/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class BriefingScene: SKScene {
    var lastTouchTime = CFAbsoluteTimeGetCurrent()
    var touchCount = 0
    var isComplete = false
    var didFail = false
    
    let backgroundSprite = SKSpriteNode(texture: SKTexture(imageNamed: "briefing_background"))
    let pointerHand = SKSpriteNode(texture: SKTexture(imageNamed: "briefing_pointerHand"))
    let phoneHand = SKSpriteNode(texture: SKTexture(imageNamed: "briefing_phoneHand"))
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 208/255, green: 206/255, blue: 184/255, alpha: 1))
        
        self.lastTouchTime = CFAbsoluteTimeGetCurrent()
        self.touchCount = 0
        self.isComplete = false
        self.didFail = false
        
        backgroundSprite.anchorPoint = CGPoint(x: 0, y: 0)
        var scaleRatio = self.size.width / backgroundSprite.size.width
        backgroundSprite.setScale(scaleRatio)
        backgroundSprite.zPosition = 1
        addChild(backgroundSprite)
        
        pointerHand.anchorPoint = CGPoint(x: 0, y: 1.0)
        pointerHand.position = CGPoint(x: backgroundSprite.size.width * 0.25, y: backgroundSprite.size.height * 0.75)
        scaleRatio = self.size.width / pointerHand.size.width
        pointerHand.setScale(scaleRatio)
        pointerHand.zPosition = 2
        addChild(pointerHand)
        
        phoneHand.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        phoneHand.position = CGPoint(x: self.size.width / 4, y: 0)
        scaleRatio = (self.size.height / 2) / phoneHand.size.height
        phoneHand.setScale(scaleRatio)
        phoneHand.zPosition = 2
        addChild(phoneHand)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchTime = CFAbsoluteTimeGetCurrent()
        touchCount += 1
        var destX : CGFloat
        var destY : CGFloat
        
        if touchCount % (briefingTouches / briefingLines) == 0 {
            destX = backgroundSprite.size.width * 0.25
            destY = pointerHand.position.y - backgroundSprite.size.height * 0.05
        } else {
            destX = pointerHand.position.x + (backgroundSprite.size.width / 2) * (1 / CGFloat(briefingTouches / briefingLines))
            destY = pointerHand.position.y
        }
        pointerHand.removeAllActions()
        pointerHand.run(SKAction.move(to: CGPoint(x: destX, y: destY), duration: 0.1))
        
        if(touchCount >= briefingTouches) {
            isComplete = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let currentTime = CFAbsoluteTimeGetCurrent()

        if currentTime - lastTouchTime > 1.5 {
            didFail = true
        } else if currentTime - lastTouchTime > 0.5 {
            let dest = CGPoint(x: phoneHand.position.x, y: phoneHand.size.height)
            phoneHand.run(SKAction.move(to: dest, duration: 1))
        } else {
            phoneHand.removeAllActions()
            phoneHand.position = CGPoint(x: self.size.width / 4, y: 0)
        }
        
        if isComplete {
            let transition = SKTransition.fade(withDuration: 0.5)
            let officeScene = OfficeScene(size: self.size)
            officeScene.briefingDone = true
            self.view?.presentScene(officeScene, transition: transition)
        } else if didFail {
            let transition = SKTransition.fade(withDuration: 0.5)
            let officeScene = OfficeScene(size: self.size)
            officeScene.briefingDone = false
            self.view?.presentScene(officeScene, transition: transition)
        }
    }
}
