//
//  TweetPile.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/5/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class TweetPile: SKSpriteNode {
    let officeScene: OfficeScene
    var isMoving = false
    var tweetPost: TweetPost!
    
    init(screenSize: CGSize, startPos: CGPoint, endPos: CGPoint, officeScene: OfficeScene) {
        self.officeScene = officeScene
                
        let texture = SKTexture(imageNamed: "tweetPile")
        let scaleRatio = (screenSize.width / scaleToScreenDict["tweetPile"]!) / texture.size().width
        let spriteSize = CGSize(width: screenSize.width / scaleToScreenDict["tweetPile"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        self.position = endPos
        self.zPosition = 4
        
        officeScene.tweetPiles.append(self)
        
        let tweetContent = getRandomTweetContent()
        tweetPost = TweetPost(screenSize: officeScene.size, text: tweetContent.text, date: tweetContent.date)
        officeScene.addChild(tweetPost)
        tweetPost.isHidden = true
    }
    
    func moveTo(location: CGPoint) {
        self.run(SKAction.move(to: location, duration: 0.01))
        isMoving = true
    }
    
    func showTweet() {
        tweetPost.isHidden = false
    }
    
    func throwAway() {
        officeScene.trump.changeNumTweets(value: -1)
        tweetPost.removeFromParent()
        self.removeFromParent()
    }
    
    func getRandomTweetContent() -> TweetContent {
        let index = Int(arc4random() % UInt32(tweetContents.count))
        return tweetContents[index]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
