//
//  GameSelectScene.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/7/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class GameSelectScene: SKScene {
    var debateGameIcon: SKSpriteNode!
    var debateGameLabel: SKLabelNode!
    var covidGameIcon: SKSpriteNode!
    var covidGameLabel: SKLabelNode!
    var conferenceGameIcon: SKSpriteNode!
    var conferenceGameLabel: SKLabelNode!
    var exitButton: SKSpriteNode!
        
    override func didMove(to view: SKView) {
        self.scaleMode = SKSceneScaleMode.aspectFit
        
        let background = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        background.lineWidth = 50
        background.fillColor = UIColor(cgColor: CGColor(srgbRed: 196/255, green: 193/255, blue: 163/255, alpha: 1))
        background.strokeColor = UIColor(cgColor: CGColor(srgbRed: 67/255, green: 42/255, blue: 29/255, alpha: 1))
        addChild(background)

        self.debateGameIcon = SKSpriteNode(imageNamed: "debateGameIcon")
        debateGameIcon.size = CGSize(width: self.size.width - 100, height: self.size.height * 0.2)
        debateGameIcon.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.7)
        debateGameIcon.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        debateGameIcon.zPosition = 1
        debateGameIcon.drawBorder(color: UIColor.black, width: 5)
        addChild(debateGameIcon)
        self.debateGameLabel = SKLabelNode(text: "Fight the Biden")
        debateGameLabel.fontName = "AvenirNext-Bold"
        debateGameLabel.fontColor = UIColor.black
        debateGameLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        debateGameLabel.position = CGPoint(x: self.size.width * 0.5, y: debateGameIcon.position.y - 10)
        debateGameIcon.zPosition = 1
        addChild(debateGameLabel)
        
        self.covidGameIcon = SKSpriteNode(imageNamed: "covidGameIcon")
        covidGameIcon.size = CGSize(width: self.size.width - 100, height: self.size.height * 0.2)
        covidGameIcon.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.4)
        covidGameIcon.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        covidGameIcon.zPosition = 1
        covidGameIcon.drawBorder(color: UIColor.black, width: 5)
        addChild(covidGameIcon)
        self.covidGameLabel = SKLabelNode(text: "It's a hoax")
        covidGameLabel.fontName = "AvenirNext-Bold"
        covidGameLabel.fontColor = UIColor.black
        covidGameLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        covidGameLabel.position = CGPoint(x: self.size.width * 0.5, y: covidGameIcon.position.y - 10)
        covidGameLabel.zPosition = 1
        addChild(covidGameLabel)
        
        self.conferenceGameIcon = SKSpriteNode(imageNamed: "conferenceGameIcon")
        conferenceGameIcon.size = CGSize(width: self.size.width - 100, height: self.size.height * 0.2)
        conferenceGameIcon.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        conferenceGameIcon.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        conferenceGameIcon.zPosition = 1
        conferenceGameIcon.drawBorder(color: UIColor.black, width: 5)
        addChild(conferenceGameIcon)
        self.conferenceGameLabel = SKLabelNode(text: "Terrible Reporters")
        conferenceGameLabel.fontName = "AvenirNext-Bold"
        conferenceGameLabel.fontColor = UIColor.black
        conferenceGameLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        conferenceGameLabel.position = CGPoint(x: self.size.width * 0.5, y: conferenceGameIcon.position.y - 10)
        conferenceGameLabel.zPosition = 1
        addChild(conferenceGameLabel)
        
        self.exitButton = SKSpriteNode(imageNamed: "exit")
        let scaleRatio = (self.size.width / scaleToScreenDict["exit"]!) / exitButton.texture!.size().width
        exitButton.size = CGSize(width: self.size.width / scaleToScreenDict["exit"]!, height: exitButton.texture!.size().height * scaleRatio)
        exitButton.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        exitButton.position = CGPoint(x: self.size.width - 70, y: self.size.height - 60)
        exitButton.zPosition = 2
        addChild(exitButton)
        exitButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        exitButton.zRotation = .pi
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let transition = SKTransition.fade(withDuration: 0.5)

            if debateGameIcon.contains(location) || debateGameLabel.contains(location) {
                let scene = DebateScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            } else if covidGameIcon.contains(location) || covidGameLabel.contains(location) {
                let scene = CovidScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            } else if conferenceGameIcon.contains(location) || conferenceGameLabel.contains(location) {
                let scene = ConferenceScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            } else if exitButton.contains(location) {
                let scene = OfficeScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
}

extension SKSpriteNode {
    func drawBorder(color: UIColor, width: CGFloat) {
        let shapeNode = SKShapeNode(rect: frame)
        shapeNode.fillColor = .clear
        shapeNode.strokeColor = color
        shapeNode.lineWidth = width
        shapeNode.position = CGPoint(x: -position.x, y: -position.y)
        addChild(shapeNode)
    }
}
