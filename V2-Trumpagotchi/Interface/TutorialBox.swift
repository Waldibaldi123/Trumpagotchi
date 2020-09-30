//
//  TutorialBox.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/24/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class TutorialBox: SKNode {
    var text: String
    let textLabel = SKLabelNode()
    let background = SKShapeNode()
    
    init(screenSize: CGSize, text: String) {
        self.text = text
        super.init()
        self.position = CGPoint(x: 10, y: screenSize.height - 50)
        self.zPosition = 110
        
        textLabel.fontSize = (screenSize.height / 900) * 25
        textLabel.fontColor = UIColor.black
        textLabel.fontName = "AmericanTypeWriter"
        textLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        textLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        textLabel.position = CGPoint(x: 14, y: 10)
        textLabel.numberOfLines = 0
        textLabel.preferredMaxLayoutWidth = screenSize.width - 36
        textLabel.text = text
        addChild(textLabel)
        
        let backgroundSize = CGSize(width: screenSize.width - 30, height: screenSize.height * 0.2)
        let backgroundPos = CGPoint(x: 10, y: -backgroundSize.height + 15)
        background.path = CGPath(rect: CGRect(origin: backgroundPos, size: backgroundSize), transform: nil)
        background.fillColor = UIColor(cgColor: CGColor(srgbRed: 248/255, green: 248/255, blue: 246/255, alpha: 1))
        background.strokeColor = UIColor.black
        background.lineWidth = 3
        addChild(background)
        
        self.isHidden = true
    }
    
    func setText(text: String) {
        self.text = text
        self.textLabel.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
