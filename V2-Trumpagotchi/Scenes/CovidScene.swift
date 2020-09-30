//
//  CovidScene.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/7/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class CovidScene: SKScene {
    let startTime = CFAbsoluteTimeGetCurrent()

    var player: SKSpriteNode!
    var cam: SKCameraNode!
    let trailPath = UIBezierPath()
    let trail = SKShapeNode()
    var ySpeed = CGFloat(150)
    
    var wallPieceBuilder: WallPieceBuilder!
    var soundActionArray: [SKAction] = []
    var numTransitions = 0
    
    var score = 0
    let scoreLabel = SKLabelNode(text: "")
    var gameOverScreen: CovidGameOver!
    
    var gameIsRunning = false
    
    override func didMove(to view: SKView) {
        /*soundActionArray.append(SKAction.playSoundFileNamed("Covid - many cases.mp3", waitForCompletion: false))
        soundActionArray.append(SKAction.playSoundFileNamed("Covid - by cases.mp3", waitForCompletion: false))
        soundActionArray.append(SKAction.playSoundFileNamed("Covid - world.mp3", waitForCompletion: false))
        soundActionArray.append(SKAction.playSoundFileNamed("Covid - go away.mp3", waitForCompletion: false))
        soundActionArray.append(SKAction.playSoundFileNamed("Covid - disinfectant.mp3", waitForCompletion: false)) */
        
        self.player = SKSpriteNode(texture: SKTexture(imageNamed: "trumpTower"), color: UIColor.clear, size: CGSize(width: 10, height: 15))
        player.zPosition = 2
        addChild(player)
        
        self.cam = SKCameraNode()
        self.camera = cam
        addChild(cam)
        
        self.backgroundColor = SKColor.white
        self.wallPieceBuilder = WallPieceBuilder(covidScene: self)
        NotificationCenter.default.addObserver(self, selector: #selector(enteredBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        scoreLabel.position = CGPoint(x: self.size.width / 2 - 10, y: self.size.height / 2 - 50)
        scoreLabel.fontName = "AvenirNext-Bold"
        cam.addChild(scoreLabel)
        
        self.gameOverScreen = CovidGameOver(covidScene: self)
        addChild(gameOverScreen)
        
        trailPath.move(to: player.position)
        trail.strokeColor = SKColor.red
        trail.lineWidth = 5
        addChild(trail)
        
       startGame()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameIsRunning {
            cam.position = player.position
            drawTrail()
            score = abs(Int(player.position.y)) * 10
            scoreLabel.text = "CO2 emission: \(score)"
            
            if wallPieceBuilder.lastWallEndPoint.x - player.position.x < self.size.width {
                wallPieceBuilder.drawSegment(startPoint: wallPieceBuilder.lastWallEndPoint)
            } 
            
            if player.position.x > wallPieceBuilder.lastTransitionStartPoint.x {
                numTransitions += 1
                ySpeed += 50
                wallPieceBuilder.lastTransitionStartPoint = wallPieceBuilder.lastWallEndPoint
                //playNextSound()
            }
            
            for wallPiece in wallPieceBuilder.wallPieces {
                if wallPiece.contains(player.position) {
                    gameOver()
                    break
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameIsRunning {
            player.removeAllActions()
            player.zRotation = -.pi / 2
            let moveAction = SKAction.repeatForever(SKAction.move(by: CGVector(dx: ySpeed / 2, dy: -ySpeed), duration: 1))
            player.run(moveAction)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameIsRunning {
            player.removeAllActions()
            player.zRotation = 0
            let moveAction = SKAction.repeatForever(SKAction.move(by: CGVector(dx: ySpeed / 2, dy: ySpeed), duration: 1))
            player.run(moveAction)
        }
    }
    
    func gameOver() {
        gameIsRunning = false
        
        for wallPiece in wallPieceBuilder.wallPieces {
            wallPiece.removeFromParent()
        }
        wallPieceBuilder.wallPieces.removeAll()
        
        for fact in wallPieceBuilder.facts {
            fact.removeFromParent()
        }
        wallPieceBuilder.facts.removeAll()
        
        player.removeAllActions()
        player.isHidden = true
        
        cam.run(SKAction.move(to: CGPoint(x: trailPath.currentPoint.x * (self.size.width / trailPath.currentPoint.x) / 2, y: self.size.height / 2), duration: 2.0))
        var scaleXRatio = self.size.width / trailPath.currentPoint.x
        scaleXRatio = scaleXRatio > 1 ? 1 : scaleXRatio
        var scaleYRatio = self.size.height / trailPath.currentPoint.y
        scaleYRatio = scaleYRatio > 1 ? 1 : scaleYRatio
        scaleYRatio = scaleYRatio < 0 ? 1 : scaleYRatio
        let lineWidthRatio = trailPath.currentPoint.x / self.size.width
        
        trail.run(SKAction.scaleX(to: scaleXRatio, duration: 2.0))
        trail.run(SKAction.scaleY(to: scaleYRatio, duration: 2.0))
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) {_ in
            self.trail.lineWidth = self.trail.lineWidth * lineWidthRatio
        }
        
        if score > gameOverScreen.highScore {
            gameOverScreen.saveNewHighscore(newHighscore: score)
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.8, repeats: false) {_ in
            self.gameOverScreen.isHidden = false
            self.gameOverScreen.newCasesLabel.text = "CO2: \(self.score) mil. tons"
            self.gameOverScreen.position = CGPoint(x: self.cam.position.x - self.size.width / 2, y: self.cam.position.y - self.size.height / 2)
        }
    }
    
    func startGame() {
        score = 0
        gameOverScreen.isHidden = true
        trailPath.removeAllPoints()
        trailPath.move(to: CGPoint(x: 0, y: 0))
        trail.run(SKAction.scaleX(to: 1.0, duration: 0.01))
        trail.run(SKAction.scaleY(to: 1.0, duration: 0.01))
        trail.lineWidth = 5
        trail.path = trailPath.cgPath
        wallPieceBuilder.lastWallEndPoint = CGPoint(x: -300, y: -5)
        wallPieceBuilder.lastTransitionStartPoint = CGPoint(x: -300, y: -5)
        player.removeAllActions()
        player.position = CGPoint(x: 0, y: 0)
        player.isHidden = false
        player.zRotation = 0
        cam.position = player.position
        ySpeed = 150
        numTransitions = 0
        wallPieceBuilder.drawSegment(startPoint: wallPieceBuilder.lastWallEndPoint)
        
        cam.run(SKAction.scale(by: (player.size.height * 3) / self.size.height, duration: 0.01))
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {_ in
            self.cam.run(SKAction.scale(to: 1.0, duration: 1.0))
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) {_ in
            let moveAction = SKAction.repeatForever(SKAction.move(by: CGVector(dx: self.ySpeed / 2, dy: self.ySpeed), duration: 1))
            self.player.run(moveAction)
            self.gameIsRunning = true
        }
    }
    
    func drawTrail() {
        trailPath.addLine(to: player.position)
        trail.path = trailPath.cgPath
    }
    
    func returnToGameSelect() {
        let timePlayed = CFAbsoluteTimeGetCurrent() - startTime
        saveTimePlayed(timePlayed: timePlayed)
        
        let gameSelectScene = GameSelectScene(size: self.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(gameSelectScene, transition: transition)
    }
    
    @objc func enteredBackground() {
        let timePlayed = CFAbsoluteTimeGetCurrent() - startTime
        saveTimePlayed(timePlayed: timePlayed)
        
        let officeScene = OfficeScene(size: self.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(officeScene, transition: transition)
    }
    
    func saveTimePlayed(timePlayed: Double) {
        let oldTimePlayed = UserDefaults.standard.double(forKey: "timePlayed")
        UserDefaults.standard.set(timePlayed + oldTimePlayed, forKey: "timePlayed")
    }
    
    func playNextSound() {
        self.run(soundActionArray[(numTransitions - 1) % soundActionArray.count])
    }
}
