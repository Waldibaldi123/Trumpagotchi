//
//  Meters.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/3/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class Meters: SKNode {
    var officeScene: OfficeScene!
    var trump: Trump!
    
    let angrySprite = SKSpriteNode(texture: SKTexture(imageNamed: "angryMeter-10"))
    var angryTextures: [SKTexture] = []
    
    let disciplineBar = SKShapeNode()
    let disciplineBarFill = SKShapeNode()
    
    let angryLabel = SKLabelNode(text: "")
    let disciplineLabel = SKLabelNode(text: "")
    let tiredLabel = SKLabelNode(text: "")
    
    init(officeScene: OfficeScene, trump: Trump) {
        self.officeScene = officeScene
        self.trump = trump
        super.init()
        
        for angryLevel in stride(from: 10, to: 110, by: 10) {
            angryTextures.append(SKTexture(imageNamed: "angryMeter-\(angryLevel)"))
        }
        
        angrySprite.size = CGSize(width: officeScene.size.width * 0.2, height: ((officeScene.size.width * 0.2) / angrySprite.size.width) * angrySprite.size.height)
        angrySprite.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        angrySprite.position = CGPoint(x: officeScene.size.width - angrySprite.size.width * 0.6, y: officeScene.size.height - 45)
        angrySprite.zPosition = 100
        addChild(angrySprite)
        
        let disciplineSize = CGSize(width: officeScene.size.width * 0.1, height: angrySprite.size.height)
        disciplineBar.path = CGPath(rect: CGRect(x: angrySprite.position.x + 10, y: angrySprite.position.y - angrySprite.size.height, width: disciplineSize.width * 0.8, height: disciplineSize.height), transform: nil)
        disciplineBar.strokeColor = UIColor.black
        disciplineBar.lineWidth = 5
        disciplineBar.zPosition = 100
        
        disciplineBarFill.path = CGPath(rect: disciplineBar.frame, transform: nil)
        disciplineBarFill.zPosition = 99
        
        let disciplineBarBackground = SKShapeNode()
        disciplineBarBackground.path = CGPath(rect: CGRect(x: angrySprite.position.x + 10, y: angrySprite.position.y - angrySprite.size.height, width: disciplineSize.width * 0.8, height: disciplineSize.height), transform: nil)
        disciplineBarBackground.fillColor = UIColor.white
        disciplineBarBackground.strokeColor = UIColor.white
        disciplineBarBackground.zPosition = 98
        
        addChild(disciplineBar)
        addChild(disciplineBarFill)
        addChild(disciplineBarBackground)
        
        /*
        angryLabel.position = CGPoint(x: officeScene.size.width * 1.0, y: officeScene.size.height * 0.9)
        angryLabel.zPosition = 300
        angryLabel.fontColor = SKColor.black
        angryLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        angryLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        angryLabel.fontName = "AvenirNext-Bold"
        //addChild(angryLabel)
        
        disciplineLabel.position = CGPoint(x: officeScene.size.width * 1.0, y: officeScene.size.height * 0.85)
        disciplineLabel.zPosition = 300
        disciplineLabel.fontColor = SKColor.black
        disciplineLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        disciplineLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        disciplineLabel.fontName = "AvenirNext-Bold"
        //addChild(disciplineLabel)
        
        tiredLabel.position = CGPoint(x: officeScene.size.width * 1.0, y: officeScene.size.height * 0.8)
        tiredLabel.zPosition = 300
        tiredLabel.fontColor = SKColor.black
        tiredLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        tiredLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        tiredLabel.fontName = "AvenirNext-Bold"
        //addChild(tiredLabel) */
    }
    
    func update() {
        var angryLevel = Int(trump.angryMeter / 10)
        if angryLevel == 10 {
            angryLevel = 9
            if !angrySprite.hasActions() {
                angrySprite.run(animateNode(textureAtlas: SKTextureAtlas(named: "angryMeterMAX"), timePerFrame: 0.2, timeOfAnimation: 0))
            }
        } else {
            angrySprite.removeAllActions()
        }
        angrySprite.texture = angryTextures[angryLevel]
        
        disciplineBarFill.path = CGPath(rect: CGRect(x: angrySprite.position.x + 10, y: angrySprite.position.y - angrySprite.size.height, width: disciplineBar.frame.width * 0.8, height: angrySprite.size.height * (CGFloat(trump.disciplineMeter) / 100)), transform: nil)
        disciplineBarFill.fillColor = UIColor.blue
        disciplineBarFill.strokeColor = UIColor.blue
        
        angryLabel.text = "Angry: \(trump.angryMeter!)"
        disciplineLabel.text = "Discipline: \(trump.disciplineMeter!)"
        tiredLabel.text = "Tired: \(trump.tiredMeter!)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
