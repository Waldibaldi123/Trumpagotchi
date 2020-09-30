//
//  Television.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/29/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class Television: SKSpriteNode {
    var officeScene: OfficeScene!
    
    var isOn: Bool!
    var timeSurvivedSeconds = 0
    let timeSurvivedLabel = SKLabelNode()
    var timeToElectionLabel = SKLabelNode()
    
    init(screenSize: CGSize, officeScene: OfficeScene) {
        self.officeScene = officeScene
        
        let texture = SKTexture(imageNamed: "televisionOff")
        let scaleRatio = (screenSize.width / scaleToScreenDict["television"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["television"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.position = CGPoint(x: relativePosDict[screenRatio]!["television"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["television"]!.y * screenSize.height)
        self.zPosition = 30
        self.isUserInteractionEnabled = true
        
        timeSurvivedLabel.text = "00:00:00:00"
        timeSurvivedLabel.fontName = "BeachPartyCartoon"
        timeSurvivedLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        timeSurvivedLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        timeSurvivedLabel.position = CGPoint(x: 0, y: self.size.height / 4 - 20)
        timeSurvivedLabel.zRotation = -.pi / 5.8
        timeSurvivedLabel.zPosition = 1
        addChild(timeSurvivedLabel)
        
        timeToElectionLabel.text = "t-00 days"
        timeToElectionLabel.fontName = "BeachPartyCartoon"
        timeToElectionLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        timeToElectionLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        timeToElectionLabel.position = CGPoint(x: 0, y: timeSurvivedLabel.position.y - timeSurvivedLabel.fontSize - 10)
        timeToElectionLabel.zRotation = -.pi / 5.8
        timeToElectionLabel.zPosition = 1
        addChild(timeToElectionLabel)
        
        self.loadData()
        if isOn {
            self.run(animateNode(textureAtlas: SKTextureAtlas(named: "televisionOn.atlas"), timePerFrame: 0.1, timeOfAnimation: 0))
            timeSurvivedLabel.isHidden = true
            timeToElectionLabel.isHidden = true
        } else {
            self.removeAllActions()
            timeSurvivedLabel.isHidden = false
            timeToElectionLabel.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        officeScene.devAvatar.showAvatar(title: televisionComment["title"] ?? "", source: televisionComment["source"] ?? "", text: televisionComment["text"] ?? "", texture: self.texture!)
        
        isOn.toggle()
        
        if isOn {
            self.run(animateNode(textureAtlas: SKTextureAtlas(named: "televisionOn.atlas"), timePerFrame: 0.3, timeOfAnimation: 0))
            timeSurvivedLabel.isHidden = true
            timeToElectionLabel.isHidden = true
        } else {
            self.removeAllActions()
            timeSurvivedLabel.isHidden = false
            timeToElectionLabel.isHidden = false
        }
    }
    
    func update() {
        timeSurvivedSeconds = Int(CFAbsoluteTimeGetCurrent() - UserDefaults.standard.double(forKey: "startTime"))
        let (d,h,m,s) = secondsToDaysHoursMinutesSeconds(seconds: timeSurvivedSeconds)
        self.timeSurvivedLabel.text = "\(d):\(h):\(m):\(s)"
        self.timeToElectionLabel.text = "t-\(getDaysUntilElection()) days"
    }
    
    //MARK: - Data Management
    
    func loadData() {
        self.isOn = UserDefaults.standard.bool(forKey: "televisionIsOn")
        timeSurvivedSeconds = Int(CFAbsoluteTimeGetCurrent() - UserDefaults.standard.double(forKey: "startTime"))
        let (d,h,m,s) = secondsToDaysHoursMinutesSeconds(seconds: timeSurvivedSeconds)
        self.timeSurvivedLabel.text = "\(d):\(h):\(m):\(s)"
    }
    
    func saveData() {
        UserDefaults.standard.set(isOn, forKey: "televisionIsOn")
    }
    
    //MARK: - Helper Functions
    
    func secondsToDaysHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int, Int) {
      return (seconds / 86400, (seconds % 86400) / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func getDaysUntilElection() -> Int {
        let days = Int((626165314 - CFAbsoluteTimeGetCurrent())) / 86400
        return days
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
