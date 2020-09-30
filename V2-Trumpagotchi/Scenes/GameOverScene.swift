//
//  GameOverScene.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/12/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    var gameOverImageName = ""
    var gameOverImage: SKSpriteNode!
    var gameOverText: String!
    var touchCount = 0
    var againButton: SKLabelNode!
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.black
        let imageTexture = SKTexture(imageNamed: gameOverImageName)
        let imageSize = CGSize(width: self.size.width - 20, height: imageTexture.size().height * (self.size.width - 20) / imageTexture.size().width)
        gameOverImage = SKSpriteNode(texture: imageTexture, size: imageSize)
        gameOverImage.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        gameOverImage.position = CGPoint(x: 10, y: self.size.height - 10)
        
        resetData()
        
        if gameOverImageName == "nuclearExplosion" {
            self.gameOverText = "You failed. Trump just started WW3."
        } else if gameOverImageName == "policeComing" {
            self.gameOverText = "You failed. Trump completely forgot he is president. "
        }
        
        enterSequence()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchCount == 1 {
            let messageLabel = SKLabelNode(text: "This is a game. Politics is not.")
            messageLabel.preferredMaxLayoutWidth = 300
            messageLabel.numberOfLines = 0
            messageLabel.fontName = "AvenirNext-Bold"
            messageLabel.position = CGPoint(x: self.size.width / 2, y: 3 * self.size.height / 4 - 200)
            messageLabel.alpha = 0.0
            addChild(messageLabel)
            messageLabel.run(SKAction.fadeIn(withDuration: 1.0))
            touchCount += 1
        } else if touchCount == 2 {
            let messageLabel = SKLabelNode(text: "Vote November 3rd!")
            messageLabel.fontName = "AvenirNext-Bold"
            messageLabel.position = CGPoint(x: self.size.width / 2, y: 3 * self.size.height / 4 - 300)
            messageLabel.alpha = 0.0
            addChild(messageLabel)
            messageLabel.run(SKAction.fadeIn(withDuration: 1.0))
            touchCount += 1
        } else if touchCount == 3 {
            againButton = SKLabelNode(text: "Try again")
            againButton.fontName = "AvenirNext-Bold"
            againButton.color = UIColor.gray
            againButton.position = CGPoint(x: self.size.width / 2, y: 3 * self.size.height / 4 - 400)
            addChild(againButton)
            touchCount += 1
        } else if let touch = touches.first {
            let location = touch.location(in: self)
            if againButton != nil && againButton.contains(location) {
                let scene = OfficeScene(size: self.size)
                scene.gameRestart = true
                let transition = SKTransition.fade(withDuration: 0.5)
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
    
    func enterSequence() {
        let gameOverLabel = SKLabelNode(text: gameOverText)
        gameOverLabel.fontName = "AvenirNext-Bold"
        gameOverLabel.position = CGPoint(x: self.size.width / 2, y: 3 * self.size.height / 4)
        gameOverLabel.alpha = 0.0
        gameOverLabel.preferredMaxLayoutWidth = 300
        gameOverLabel.numberOfLines = 0
        addChild(gameOverLabel)
        gameOverLabel.run(SKAction.fadeIn(withDuration: 1.0))
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {_ in
            self.touchCount = 1
        }
    }
    
    func resetData() {
        let defaults = UserDefaults.standard
        defaults.set(CFAbsoluteTimeGetCurrent(), forKey: "lastAppOpenTime")
        defaults.set(12, forKey: "deskCokeAmount")
        defaults.set(false, forKey: "televisionIsOn")
        defaults.set(CFAbsoluteTimeGetCurrent() - briefingAvailableInterval, forKey: "briefingLastReadTime")
        defaults.set(0, forKey: "trumpAngryMeter")
        defaults.set(100, forKey: "trumpDisciplineMeter")
        defaults.set(0, forKey: "trumpTiredMeter")
        defaults.set(0, forKey: "trumpNumTweets")
        defaults.set(0, forKey: "timePlayed")
        defaults.set(CFAbsoluteTimeGetCurrent(), forKey: "startTime")
    }
}
