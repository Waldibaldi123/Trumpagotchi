//
//  Utilities.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/30/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

func animateNode(textureAtlas: SKTextureAtlas, timePerFrame: Double, timeOfAnimation: CGFloat) -> SKAction {
    let animationNames = textureAtlas.textureNames
    var animationFrames: [SKTexture] = []
    let numImages = textureAtlas.textureNames.count
    for i in 1...numImages {
        let textureName = "\(animationNames[i-1])"
        animationFrames.append(textureAtlas.textureNamed(textureName))
    }
    
    if (timeOfAnimation == 0) {
        return SKAction.repeatForever(
        SKAction.animate(with: animationFrames,
                         timePerFrame: timePerFrame,
                         resize: false,
                         restore: true))
    } else {
        let count = Int(Double(timeOfAnimation) / (Double(animationFrames.count) * timePerFrame))
        return SKAction.repeat(
            SKAction.animate(with: animationFrames,
                             timePerFrame: timePerFrame,
                             resize: false,
                             restore: true), count: count)
    }
}

func scheduleNotificationWith(body: String, intervalInSeconds: TimeInterval) {
    let localNotification = UNMutableNotificationContent()
    
    localNotification.body = body
    localNotification.sound = UNNotificationSound.default
    
    let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: intervalInSeconds, repeats: false)
    let request = UNNotificationRequest.init(identifier: body, content: localNotification, trigger: trigger)
    
    let center = UNUserNotificationCenter.current()
    center.add(request)
}

func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
    return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y))
}

func randomCGPoint(inSize: CGSize) -> CGPoint {
    let destX = random(min: 0, max: inSize.width)
    let destY = random(min: 0, max: inSize.height)
    
    return CGPoint(x: destX, y: destY)
}

func positionsEqual(pos1: CGPoint, pos2: CGPoint) -> Bool {
    let pos1X = pos1.x.rounded(.toNearestOrEven)
    let pos2X = pos2.x.rounded(.toNearestOrEven)
    let pos1Y = pos1.y.rounded(.toNearestOrEven)
    let pos2Y = pos2.y.rounded(.toNearestOrEven)
    
    return (pos1X == pos2X && pos1Y == pos2Y)
}

class TweetContent {
    var text: String
    var date: String
    
    init(text: String, date: String) {
        self.text = text
        self.date = date
    }
}
