//
//  Desk.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/29/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class Desk: SKSpriteNode {
    var officeScene: OfficeScene!
    var cokeBottle: CokeBottle!
    
    var isOpen = false
    var cokeAmount: Int!
    
    var widthCorrection: CGFloat!
    
    init(screenSize: CGSize, officeScene: OfficeScene) {
        self.officeScene = officeScene
        
        let texture = SKTexture(imageNamed: "desk-closed")
        let scaleRatio = (screenSize.width / scaleToScreenDict["desk"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["desk"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        let screenRatio = String(Double(floor(100 * (screenSize.height / screenSize.width)) / 100))
        self.position = CGPoint(x: relativePosDict[screenRatio]!["desk"]!.x * screenSize.width, y: relativePosDict[screenRatio]!["desk"]!.y * screenSize.height)
        self.zPosition = 20
        self.isUserInteractionEnabled = true
        
        self.widthCorrection = self.size.width * 0.07
        
        self.loadData()
    }
    
    //MARK: - User Interaction
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isOpen.toggle()
        
        if isOpen {
            self.size = CGSize(width: self.size.width + widthCorrection, height: self.size.height)
            self.texture = SKTexture(imageNamed: "desk-open-\(cokeAmount!)")
            officeScene.cokeBottle.isHidden = false
        } else {
            self.size = CGSize(width: self.size.width - widthCorrection, height: self.size.height)
            self.texture = SKTexture(imageNamed: "desk-closed")
            officeScene.cokeBottle.isHidden = true
        }
    }
    
    //MARK: - Field Manipulations
    
    func changeCokeAmount(value: Int) {
        cokeAmount += value
        if cokeAmount > 12 {
            cokeAmount = 12
        } else if cokeAmount < 0 {
            cokeAmount = 0
        }
        
        if isOpen {
            self.texture = SKTexture(imageNamed: "desk-open-\(cokeAmount!)")
        }
    }
    
    //MARK: - Data Management
    
    func loadData() {
        self.cokeAmount = UserDefaults.standard.integer(forKey: "deskCokeAmount")
    }
    
    func saveData() {
        UserDefaults.standard.set(cokeAmount, forKey: "deskCokeAmount")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
