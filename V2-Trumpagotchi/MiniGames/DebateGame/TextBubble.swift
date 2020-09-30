//
//  TextBubble.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/6/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class TextBubble: SKLabelNode {
    init(screenSize: CGSize) {
        super.init()
        self.text = "Your Organisation is terrible"
        self.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.position = CGPoint(x: screenSize.width / 2, y: screenSize.height - 150)
        self.numberOfLines = 0
        self.preferredMaxLayoutWidth = 200
        self.fontColor = SKColor.black
        self.fontName = "AvenirNext-Bold"
        self.fontSize = 25
        self.zPosition = 2
        
        let bubble = SKShapeNode(ellipseIn: CGRect(x: 0, y: 0, width: 250, height: 150))
        bubble.fillColor = UIColor.lightGray
        bubble.zPosition = 1
        bubble.position = CGPoint(x: -125, y: -75)
        bubble.alpha = 0.2
        addChild(bubble)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
