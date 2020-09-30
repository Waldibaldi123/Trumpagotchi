//
//  DevAvatar.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 9/7/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class DevAvatar: SKSpriteNode {
    var title: String = ""
    var source: String = ""
    var text: String = ""
    var objectTexture: SKTexture!
    var timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) {_ in}

    init(screenSize: CGSize) {
        let texture = SKTexture(imageNamed: "devAvatar")
        let scaleRatio = (screenSize.width / scaleToScreenDict["devAvatar"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["devAvatar"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        self.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        self.position = CGPoint(x: 10, y: screenSize.height - 30)
        
        self.zPosition = 100
        self.isHidden = true
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let devComment = DevComment(screenSize: self.scene!.size)
        devComment.setText(title: title, source: source, text: text, texture: objectTexture)
        self.scene!.addChild(devComment)
        
        self.isHidden = true
    }
    
    func showAvatar(title: String, source: String, text: String, texture: SKTexture) {
        self.title = title
        self.source = source
        self.text = text
        self.objectTexture = texture
        self.isHidden = false
        
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) {_ in
            self.isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
