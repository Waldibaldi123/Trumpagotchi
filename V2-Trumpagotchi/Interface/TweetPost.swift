//
//  TweetPost.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/21/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class TweetPost: SKNode {
    
    init(screenSize: CGSize, text: String, date: String) {
        super.init()
        self.position = CGPoint(x: 0, y: screenSize.height - 30)
        self.zPosition = 111
        
        let profileSprite = SKSpriteNode(imageNamed: "trump-standing")
        profileSprite.size = CGSize(width: screenSize.width * 0.15, height: screenSize.width * 0.15)
        profileSprite.anchorPoint = CGPoint(x: 0, y: 1.0)
        profileSprite.position = CGPoint(x: 10, y: 0)
        addChild(profileSprite)
        
        let nameLabel = SKLabelNode(text: "Donald J. Trump")
        nameLabel.fontName = "AvenirNext-Bold"
        nameLabel.fontSize = 20
        nameLabel.fontColor = UIColor.black
        nameLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        nameLabel.position = CGPoint(x: profileSprite.position.x + profileSprite.size.width + 10, y: profileSprite.position.y - 30)
        addChild(nameLabel)
        
        let tagLabel = SKLabelNode(text: "@realDonaldTrump")
        tagLabel.fontSize = 20
        tagLabel.fontColor = UIColor.gray
        tagLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        tagLabel.position = CGPoint(x: nameLabel.position.x, y: nameLabel.position.y - nameLabel.fontSize - 5)
        addChild(tagLabel)
        
        let textLabel = SKLabelNode(text: text)
        textLabel.fontSize = 25
        textLabel.fontColor = UIColor.black
        textLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        textLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        textLabel.position = CGPoint(x: profileSprite.position.x, y: profileSprite.position.y - profileSprite.size.height - 5)
        textLabel.numberOfLines = 0
        textLabel.preferredMaxLayoutWidth = screenSize.width - 20
        addChild(textLabel)
        
        let dateLabel = SKLabelNode(text: date)
        dateLabel.fontSize = 20
        dateLabel.fontColor = UIColor.gray
        dateLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        dateLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        dateLabel.position = CGPoint(x: textLabel.position.x, y: textLabel.position.y - textLabel.frame.height - 10)
        addChild(dateLabel)
        
        let background = SKShapeNode()
        let backgroundSize = CGSize(width: screenSize.width, height: profileSprite.size.height + textLabel.frame.height + dateLabel.frame.height + 50)
        let backgroundPos = CGPoint(x: 0, y: -backgroundSize.height + 30)
        background.path = CGPath(rect: CGRect(origin: backgroundPos, size: backgroundSize), transform: nil)
        background.fillColor = UIColor.white
        addChild(background)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
