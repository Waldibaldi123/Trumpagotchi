//
//  Background.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/29/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class Background: SKSpriteNode {
    let officeScene: OfficeScene
    let window = SKSpriteNode(texture: SKTexture(imageNamed: "window"))
    
    init(screenSize: CGSize, officeScene: OfficeScene) {
        self.officeScene = officeScene
        let texture = SKTexture(imageNamed: "background")
        let scaleRatio = (screenSize.width / scaleToScreenDict["background"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["background"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.position = CGPoint(x: relativePosDict[screenRatio]!["background"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["background"]!.y * screenSize.height)
        self.zPosition = 2
        
        window.size = spriteSize
        window.zPosition = -1
        addChild(window)
    }
    
    func update() {
        let trumpDiscipline = officeScene.trump.disciplineMeter!
        
        if trumpDiscipline == 0 && window.action(forKey: "fire") == nil {
            self.removeAllActions()
            window.removeAllActions()
            window.run(animateNode(textureAtlas: SKTextureAtlas(named: "windowFire"), timePerFrame: 0.3, timeOfAnimation: 0), withKey: "fire")
            self.run(animateNode(textureAtlas: SKTextureAtlas(named: "backgroundFire"), timePerFrame: 0.3, timeOfAnimation: 0))
        } else if trumpDiscipline > 0 && trumpDiscipline < 33 && window.action(forKey: "shadows") == nil {
            self.removeAllActions()
            window.removeAllActions()
            window.run(animateNode(textureAtlas: SKTextureAtlas(named: "windowShadows"), timePerFrame: 0.3, timeOfAnimation: 0), withKey: "shadows")
        } else if trumpDiscipline >= 33 && trumpDiscipline < 66 && window.action(forKey: "protest") == nil {
            self.removeAllActions()
            window.removeAllActions()
            window.run(animateNode(textureAtlas: SKTextureAtlas(named: "windowProtest"), timePerFrame: 1.0, timeOfAnimation: 0), withKey: "protest")
        } else if trumpDiscipline >= 66 {
            self.removeAllActions()
            window.removeAllActions()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
