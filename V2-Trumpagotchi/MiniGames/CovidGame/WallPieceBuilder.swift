//
//  WallPieces.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/12/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class WallPieceBuilder {
    let covidScene: CovidScene
    var wallPieces: [SKShapeNode] = []
    var facts: [SKLabelNode] = []
    var lastWallEndPoint: CGPoint = CGPoint(x: -300, y: -50)
    var lastTransitionStartPoint: CGPoint = CGPoint(x: -300, y: -50)
    
    init(covidScene: CovidScene) {
        self.covidScene = covidScene
    }
    
    func drawSegment(startPoint: CGPoint) {
        let xSpeed = covidScene.ySpeed / 2
        let segmentLengh = xSpeed * 22
        lastWallEndPoint = drawTransitionPiece(startPoint: lastWallEndPoint)
        while lastWallEndPoint.x - startPoint.x < segmentLengh {
            lastWallEndPoint = drawRandomWallPiece(startPoint: lastWallEndPoint)
        }
    }
    
    func drawTransitionPiece(startPoint: CGPoint) -> CGPoint {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: path.currentPoint.x + 800, y: path.currentPoint.y + 0))
        path.addLine(to: CGPoint(x: path.currentPoint.x + 200, y: path.currentPoint.y + 400))
        let endPoint = path.currentPoint
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y - covidScene.size.height * 2))
        path.addLine(to: CGPoint(x: path.currentPoint.x - 1000, y: path.currentPoint.y))
        path.addLine(to: startPoint)
        
        path.move(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + 100))
        path.addLine(to: CGPoint(x: path.currentPoint.x + 200, y: path.currentPoint.y + 400))
        path.addLine(to: CGPoint(x: path.currentPoint.x + 800, y: path.currentPoint.y + 0))
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + covidScene.size.height * 2))
        path.addLine(to: CGPoint(x: path.currentPoint.x - 1000, y: path.currentPoint.y))
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + 400))

        let wallPiece = SKShapeNode()
        wallPiece.path = path.cgPath
        wallPiece.fillColor = UIColor.darkGray
        wallPiece.strokeColor = UIColor.darkGray
        
        let fact = SKLabelNode()
        if covidScene.numTransitions < covidFacts.count {
            fact.text = covidFacts[covidScene.numTransitions]
        } else {
            fact.text = ""
        }
        fact.fontSize = 30
        fact.fontName = "AvenirNext-Bold"
        fact.fontColor = UIColor.black
        fact.numberOfLines = 0
        fact.preferredMaxLayoutWidth = 500
        fact.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        fact.position = CGPoint(x: startPoint.x + 250, y: startPoint.y + 250)
        fact.zPosition = -1
        
        covidScene.addChild(wallPiece)
        wallPieces.append(wallPiece)
        covidScene.addChild(fact)
        facts.append(fact)
        
        return endPoint
    }
    
    func drawRandomWallPiece(startPoint: CGPoint) -> CGPoint {
        let randUpDown = arc4random() % 12
        let randY = arc4random() % 6 + 1
        let yLength: CGFloat
        
        if randUpDown < 5 {
            yLength = CGFloat(randY) * -50
        } else {
            yLength = CGFloat(randY) * 50
        }
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: path.currentPoint.x + abs(yLength / 2), y: path.currentPoint.y + yLength))
        path.addLine(to: CGPoint(x: path.currentPoint.x + abs(yLength / 4), y: path.currentPoint.y - yLength / 2))
        let endPoint = path.currentPoint
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y - covidScene.size.height * 2))
        path.addLine(to: CGPoint(x: path.currentPoint.x - abs(3 * yLength / 4), y: path.currentPoint.y))
        path.addLine(to: startPoint)
        
        path.move(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + 100))
        path.addLine(to: CGPoint(x: path.currentPoint.x + abs(yLength / 2), y: path.currentPoint.y + yLength))
        path.addLine(to: CGPoint(x: path.currentPoint.x + abs(yLength / 4), y: path.currentPoint.y - yLength / 2))
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + covidScene.size.height * 2))
        path.addLine(to: CGPoint(x: path.currentPoint.x - abs(3 * yLength / 4), y: path.currentPoint.y))
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + 100))
        
        let wallPiece = SKShapeNode()
        wallPiece.path = path.cgPath
        wallPiece.fillColor = UIColor.darkGray
        wallPiece.strokeColor = UIColor.darkGray
        
        covidScene.addChild(wallPiece)
        wallPieces.append(wallPiece)
        
        return endPoint
    }
}
