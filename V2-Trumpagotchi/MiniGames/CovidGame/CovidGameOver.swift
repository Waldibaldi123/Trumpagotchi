//
//  CovidGameOver.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/11/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class CovidGameOver: SKShapeNode {
    let covidScene: CovidScene
    var highScore: Int!
    
    var newCasesLabel: SKLabelNode!
    var highScoreLabel: SKLabelNode!
    var againButton: SKLabelNode!
    var returnButton: SKLabelNode!
    
    init(covidScene: CovidScene) {
        self.covidScene = covidScene
        super.init()
        let size = covidScene.size
        let position = CGPoint(x: 0, y: 0)
        self.path = CGPath(rect: CGRect(origin: position, size: size), transform: nil)
        self.fillColor = UIColor.darkGray
        self.alpha = 0.7
        self.isHidden = true
        self.isUserInteractionEnabled = true
        self.zPosition = 2
        
        newCasesLabel = SKLabelNode(text: "CO2 emission: \(covidScene.score) million metric tons")
        newCasesLabel.fontName = "AvenirNext-Bold"
        newCasesLabel.fontColor = UIColor.white
        newCasesLabel.position = CGPoint(x: covidScene.size.width / 2, y: covidScene.size.height / 2)
        addChild(newCasesLabel)
        
        highScoreLabel = SKLabelNode(text: "Highscore: ")
        highScoreLabel.fontName = "AvenirNext-Bold"
        highScoreLabel.fontColor = UIColor.white
        highScoreLabel.position = CGPoint(x: newCasesLabel.position.x, y: newCasesLabel.position.y - newCasesLabel.frame.height - 20)
        addChild(highScoreLabel)
        
        self.againButton = SKLabelNode(text: "Again")
        againButton.fontColor = UIColor.white
        let againBackground = SKShapeNode(rect: againButton.frame, cornerRadius: 5.0)
        againBackground.fillColor = UIColor.red
        againBackground.strokeColor = UIColor.red
        againButton.addChild(againBackground)
        againButton.position = CGPoint(x: highScoreLabel.position.x, y: highScoreLabel.position.y - highScoreLabel.frame.height - 20)
        addChild(againButton)
        
        self.returnButton = SKLabelNode(text: "No more denial")
        returnButton.fontColor = UIColor.white
        let returnBackground = SKShapeNode(rect: returnButton.frame, cornerRadius: 5.0)
        returnBackground.fillColor = UIColor.blue
        returnBackground.strokeColor = UIColor.blue
        returnButton.addChild(returnBackground)
        returnButton.position = CGPoint(x: againButton.position.x, y: againButton.position.y - againButton.frame.height - 20)
        addChild(returnButton)
        
        loadHighscore()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if againButton.contains(location) {
                covidScene.startGame()
            } else if returnButton.contains(location) {
                covidScene.returnToGameSelect()
            }
        }
    }
    
    func loadHighscore() {
        self.highScore = UserDefaults.standard.integer(forKey: "covidHighscore")
        highScoreLabel.text = "Highscore: \(highScore!)"
    }
    
    func saveNewHighscore(newHighscore: Int) {
        highScore = newHighscore
        highScoreLabel.text = "Highscore: \(highScore!)"
        UserDefaults.standard.set(highScore, forKey: "covidHighscore")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
