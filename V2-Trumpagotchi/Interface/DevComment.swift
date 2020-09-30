//
//  DevComment.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 9/3/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class DevComment: SKNode {
    let titleLabel = SKLabelNode()
    let sourceLabel = SKLabelNode()
    let textLabel = SKLabelNode()
    let avatar = SKSpriteNode()
    let background = SKShapeNode()
    let screenSize: CGSize
    
    init(screenSize: CGSize) {
        self.screenSize = screenSize
        super.init()
        self.position = CGPoint(x: 10, y: screenSize.height)
        self.zPosition = 111
        self.isUserInteractionEnabled = true
        
        avatar.texture = SKTexture(imageNamed: "commentObject")
        let scaleRatio = (screenSize.width / scaleToScreenDict["commentObject"]!) / avatar.texture!.size().width
        avatar.size = CGSize(width: screenSize.width / scaleToScreenDict["commentObject"]!, height: avatar.texture!.size().height * scaleRatio)
        avatar.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        avatar.position = CGPoint(x: 5, y: -45)
        addChild(avatar)
        
        titleLabel.fontSize = (screenSize.height / 900) * 25
        titleLabel.fontColor = UIColor.black
        titleLabel.fontName = "AmericanTypeWriter-Bold"
        titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        titleLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        titleLabel.position = CGPoint(x: avatar.size.width + 22, y: -50)
        addChild(titleLabel)
        
        sourceLabel.fontSize = (screenSize.height / 900) * 25
        sourceLabel.fontColor = UIColor.black
        sourceLabel.fontName = "AmericanTypeWriter-CondensedLight"
        sourceLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        sourceLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        sourceLabel.position = CGPoint(x: avatar.size.width + 22, y: -titleLabel.fontSize - 60)
        addChild(sourceLabel)
        
        textLabel.fontSize = (screenSize.height / 900) * 25
        textLabel.fontColor = UIColor.black
        textLabel.fontName = "AmericanTypeWriter"
        textLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        textLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        textLabel.position = CGPoint(x: 7, y: -avatar.size.height - 60)
        textLabel.numberOfLines = 0
        textLabel.preferredMaxLayoutWidth = screenSize.width - 28
        addChild(textLabel)
        
        let backgroundSize = CGSize(width: screenSize.width - 20, height: screenSize.height - 20)
        let backgroundPos = CGPoint(x: 0, y: -backgroundSize.height - 10)
        background.path = CGPath(rect: CGRect(origin: backgroundPos, size: backgroundSize), transform: nil)
        background.fillColor = UIColor(cgColor: CGColor(srgbRed: 248/255, green: 248/255, blue: 246/255, alpha: 1))
        background.strokeColor = UIColor.black
        background.lineWidth = 3
        addChild(background)
    }
    
    func setText(title: String, source: String, text: String, texture: SKTexture) {
        self.titleLabel.text = title
        self.sourceLabel.text = source
        self.textLabel.text = text
        self.avatar.texture = texture
        let scaleRatio = (screenSize.width / scaleToScreenDict["commentObject"]!) / avatar.texture!.size().width
        avatar.size = CGSize(width: screenSize.width / scaleToScreenDict["commentObject"]!, height: avatar.texture!.size().height * scaleRatio)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromParent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
