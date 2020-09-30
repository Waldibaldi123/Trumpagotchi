//
//  Briefing.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/30/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class Briefing: SKSpriteNode {
    var officeScene: OfficeScene!
    var lastReadTime: CFAbsoluteTime!
    
    init(screenSize: CGSize, officeScene: OfficeScene) {
        self.officeScene = officeScene
        
        let texture = SKTexture(imageNamed: "briefing")
        let scaleRatio = (screenSize.width / scaleToScreenDict["briefing"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["briefing"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.position = CGPoint(x: relativePosDict[screenRatio]!["briefing"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["briefing"]!.y * screenSize.height)
        self.zPosition = 21
        self.isUserInteractionEnabled = true
        
        loadData()
    }
    
    func update() {
        let currentTime = CFAbsoluteTimeGetCurrent()
        if currentTime - lastReadTime > briefingAvailableInterval {
            self.isHidden = false
        } else {
            self.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if officeScene.trump.stateMachine.currentState is IdleState {
            officeScene.transitionToBriefing()
        }
    }
    
    func makeAvailable() {
        lastReadTime = CFAbsoluteTimeGetCurrent() - briefingAvailableInterval
        saveData()
    }
    
    //MARK: - Data Management
    
    func loadData() {
        self.lastReadTime = UserDefaults.standard.double(forKey: "briefingLastReadTime")
    }
    
    func saveData() {
        UserDefaults.standard.set(lastReadTime, forKey: "briefingLastReadTime")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
