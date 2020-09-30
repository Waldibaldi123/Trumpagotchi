//
//  Pathfinding.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/2/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class PathFinder {
    var screenSize: CGSize!
    var officeScene: OfficeScene!
    var obstacles: [SKSpriteNode] = []

    init(officeScene: OfficeScene) {
        self.screenSize = officeScene.size
        self.officeScene = officeScene
        
        let size1 = CGSize(width: officeScene.desk.size.width + 50, height: officeScene.desk.size.height / 2)
        let obstacle1 = SKSpriteNode(texture: officeScene.desk.texture, color: UIColor.clear, size: size1)
        obstacle1.position = CGPoint(x: officeScene.desk.position.x, y: officeScene.desk.position.y - officeScene.desk.size.height / 4)
        obstacles.append(obstacle1)
        
        let size2 = CGSize(width: officeScene.television.size.width + 50, height: officeScene.television.size.height / 2)
        let obstacle2 = SKSpriteNode(texture: officeScene.television.texture, color: UIColor.clear, size: size2)
        obstacle2.position = CGPoint(x: officeScene.television.position.x, y: officeScene.television.position.y - officeScene.television.size.height / 4)
        obstacles.append(obstacle2)
    }
    
    func getRandomTweetPoint() -> CGPoint {
        var point = randomCGPoint(inSize: screenSize)
        while(!pointIsTweetable(point: point)) {
            point = randomCGPoint(inSize: screenSize)
        }
        return point
    }
    
    func pointIsTweetable(point: CGPoint) -> Bool {
        for obstacle in obstacles {
            if obstacle.contains(point) {
                return false
            }
        }
        
        let tweetablePath = UIBezierPath()
        tweetablePath.move(to: CGPoint(x: 50, y: 50))
        tweetablePath.addLine(to: CGPoint(x: screenSize.width - 50, y: 50))
        tweetablePath.addLine(to: CGPoint(x: screenSize.width - 50, y: officeScene.television.position.y))
        tweetablePath.addLine(to: CGPoint(x: officeScene.television.position.x - officeScene.television.size.width * 0.5, y: officeScene.television.position.y))
        tweetablePath.addLine(to: CGPoint(x: officeScene.television.position.x - officeScene.television.size.width * 0.5, y: officeScene.desk.position.y))
        tweetablePath.addLine(to: CGPoint(x: 50, y: officeScene.desk.position.y))
        tweetablePath.addLine(to: CGPoint(x: 50, y: 50))
        
        if tweetablePath.contains(point) {
            return true
        }
        return false
    }
    
    func getRandomWalkablePoint() -> CGPoint {
        var point = randomCGPoint(inSize: screenSize)
        while(!pointIsWalkable(point: point)) {
            point = randomCGPoint(inSize: screenSize)
        }
        return point
    }
    
    func pointIsWalkable(point: CGPoint) -> Bool {
        for obstacle in obstacles {
            if obstacle.contains(point) {
                return false
            }
        }
        
        let walkablePath = UIBezierPath()
        walkablePath.move(to: CGPoint(x: 50, y: 0))
        walkablePath.addLine(to: CGPoint(x: screenSize.width - 50, y: 0))
        walkablePath.addLine(to: CGPoint(x: screenSize.width - 50, y: screenSize.height * 0.66))
        walkablePath.addLine(to: CGPoint(x: screenSize.width * 0.3, y: screenSize.height * 0.68))
        walkablePath.addLine(to: CGPoint(x: screenSize.width * 0.5, y: screenSize.height * 0.7))
        walkablePath.addLine(to: CGPoint(x: 50, y: screenSize.height * 0.66))
        walkablePath.addLine(to: CGPoint(x: 50, y: 0))
        
        if walkablePath.contains(point) {
            return true
        }
        return false
    }

    func buildPath(start: CGPoint, dest: CGPoint) -> UIBezierPath {
        var currentStartPoint = start
        var pathPoints: [CGPoint] = []
        pathPoints.append(start)
        
        //assume there is a collision
        var collisionFound = true
        //my algorithm sucks, hence breakout variable for the worst
        var loopCount = 0
                
        while collisionFound && loopCount < 5 {
            loopCount += 1
            currentStartPoint = pathPoints[pathPoints.endIndex - 1]
            let stepValue = (dest.y - currentStartPoint.y) / CGFloat(500)
            let yStride = stride(from: currentStartPoint.y, to: dest.y, by: stepValue)
            //TODO: special case yRange is empty !!!!!!!!!!!!
            let xDiff = dest.x - currentStartPoint.x
            let yDiff = dest.y - currentStartPoint.y
                        
            for currentY in yStride {
                let currentX = pathPoints[pathPoints.endIndex - 1].x + xDiff * (abs((CGFloat(currentY) - pathPoints[pathPoints.endIndex - 1].y)) / CGFloat(Int(abs(yDiff))))
                collisionFound = false
                let currentPoint = CGPoint(x: currentX, y: currentY)
                
                for obstacle in obstacles {
                    if obstacle.contains(currentPoint) {
                        pathPoints.append(currentPoint)
                        collisionFound = true
                        
                        //find cornerpoints and next turning point
                        var cornerPointsToDest = getCornerPoints(node: obstacle)
                        //rank cornerPoints distance-wise
                        cornerPointsToDest.sort {
                            CGPointDistance(from: $0, to: dest) < CGPointDistance(from: $1, to: dest)
                        }
                        var cornerPointsToCollision = cornerPointsToDest.sorted {
                            CGPointDistance(from: $0, to: currentPoint) < CGPointDistance(from: $1, to: currentPoint)
                        }
                        let xDiffCollision = currentPoint.x - cornerPointsToCollision[0].x
                        let yDiffCollision = currentPoint.y - cornerPointsToCollision[0].y
                        
                        let side = abs(xDiffCollision) < abs(yDiffCollision) ? "x" : "y"
                        if side == "x" && cornerPointsToCollision[2].x == cornerPointsToCollision[0].x {
                            cornerPointsToCollision[1] = cornerPointsToCollision[2]
                        } else if side == "y" && cornerPointsToCollision[2].y == cornerPointsToCollision[0].y {
                            cornerPointsToCollision[1] = cornerPointsToCollision[2]
                        }
                        
                        for cornerPoint in cornerPointsToDest {
                            if cornerPoint.x == cornerPointsToCollision[0].x && cornerPoint.y == cornerPointsToCollision[0].y || cornerPoint.x == cornerPointsToCollision[1].x && cornerPoint.y == cornerPointsToCollision[1].y {
                                
                                let xBuffer = xDiffCollision < 0 ? 1 : -1
                                let yBuffer = yDiffCollision < 0 ? 1 : -1
                                let turnPoint = CGPoint(x: cornerPoint.x + CGFloat(xBuffer), y: cornerPoint.y + CGFloat(yBuffer))
                                pathPoints.append(turnPoint)
                                break
                            }
                        }
                        break
                    }
                }
                if collisionFound {
                    break
                }
            }
        }
        
        pathPoints.append(dest)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        for index in 1..<pathPoints.count {
            path.addLine(to: CGPoint(x: pathPoints[index].x - pathPoints[0].x, y: pathPoints[index].y - pathPoints[0].y))
        }
        
        return path
    }
    
    private func getCornerPoints(node: SKSpriteNode) -> [CGPoint] {
        var cornerPoints: [CGPoint] = []
        cornerPoints.append(CGPoint(x: node.position.x - node.size.width / 2, y: node.position.y - node.size.height / 2))
        cornerPoints.append(CGPoint(x: node.position.x + node.size.width / 2, y: node.position.y - node.size.height / 2))
        cornerPoints.append(CGPoint(x: node.position.x - node.size.width / 2, y: node.position.y + node.size.height / 2))
        cornerPoints.append(CGPoint(x: node.position.x + node.size.width / 2, y: node.position.y + node.size.height / 2))
        
        return cornerPoints
    }
}
