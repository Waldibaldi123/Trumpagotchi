//
//  Tile.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/6/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class Tile: SKShapeNode {
    let debateScene: DebateScene
    var touched = false
    var id: Int
    
    init(debateScene: DebateScene, lane: Int, id: Int) {
        self.debateScene = debateScene
        debateScene.waveCounter += 1
        self.id = id
        super.init()
        
        let size = CGSize(width: debateScene.size.width / 4, height: debateScene.size.height / relativeTileHeight)
        let position = CGPoint(x: (debateScene.size.width * CGFloat(lane)) / 4, y: debateScene.size.height)
        self.path = CGPath(rect: CGRect(origin: position, size: size), transform: nil)
        self.fillColor = SKColor.blue
        self.strokeColor = UIColor(cgColor: CGColor(srgbRed: 0, green: 0, blue: 140/255, alpha: 1.0))
        self.lineWidth = 5
        self.isUserInteractionEnabled = true
        self.alpha = 0.2
        self.zPosition = 2
        
        self.run(SKAction.move(to: CGPoint(x: self.position.x, y: -debateScene.size.height - self.frame.height), duration: debateScene.tileDuration), withKey: "move")
        self.run(SKAction.fadeAlpha(to: 1.0, duration: debateScene.tileDuration / 2))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !touched {
            if id - 1 != debateScene.lastIdTouched {
                debateScene.gameLost()
            } else {
                debateScene.playRandomTileSound()
                debateScene.lastIdTouched += 1
                debateScene.score += 1
            }
            touched = true
            self.fillColor = UIColor.red
            self.strokeColor = UIColor(cgColor: CGColor(srgbRed: 137/255, green: 2/255, blue: 2/255, alpha: 1.0))
        }
    }
    
    func remove() {
        if !touched {
            self.removeAllActions()
            self.isUserInteractionEnabled = false
            self.position = CGPoint(x: self.position.x, y: -debateScene.size.height)
            self.fillColor = UIColor.red
            self.strokeColor = UIColor(cgColor: CGColor(srgbRed: 137/255, green: 2/255, blue: 2/255, alpha: 1.0))
            let blinkAction = SKAction.sequence([SKAction.fadeAlpha(to: 1.0, duration: 0.3), SKAction.fadeAlpha(to: 0.0, duration: 0.3), SKAction.fadeAlpha(to: 0.0, duration: 0.3), SKAction.fadeAlpha(to: 1.0, duration: 0.3)])
            self.run(blinkAction)
            debateScene.gameLost()
        } else {
            self.removeFromParent()
        }
    }
    
    func removeFromParentAction() -> SKAction {
        let removeAction = SKAction.run({ [weak self] in
            self?.removeFromParent()
        })
        return removeAction
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
