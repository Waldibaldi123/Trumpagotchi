//
//  DebateScene.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/6/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class DebateScene: SKScene {
    let startTime = CFAbsoluteTimeGetCurrent()
    
    var score = 0
    var wave = 1
    var waveLength = 20
    var waveCounter = 0
    var tileDuration = Double(tileStartDuration)
    
    var timer: Timer!
    var tileArr: [Tile] = []
    var lastIdTouched = -1
    var totalTiles = 0
    
    let scoreLabel = SKLabelNode(text: "")
    var trumpSprite: TrumpSprite!
    var bidenSprite: BidenSprite!
    var gameOverScreen: DebateGameOver!
    
    var soundActionArray: [SKAction] = []
    let bgMusicNode = SKAudioNode(fileNamed: "Debate - Circus.mp3")
    var bidenSoundArray: [SKAction] = []
    var bidenSoundIndex = 0
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.white
        NotificationCenter.default.addObserver(self, selector: #selector(enteredBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        scoreLabel.fontColor = UIColor.black
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.position = CGPoint(x: self.size.width * 0.95, y: self.size.height * 0.95)
        addChild(scoreLabel)
        
        self.trumpSprite = TrumpSprite(screenSize: self.size)
        addChild(trumpSprite)
        self.bidenSprite = BidenSprite(screenSize: self.size)
        addChild(bidenSprite)
        self.gameOverScreen = DebateGameOver(debateScene: self)
        addChild(gameOverScreen)
        
        soundActionArray.append(SKAction.playSoundFileNamed("Debate - Bing.mp3", waitForCompletion: false))
        soundActionArray.append(SKAction.playSoundFileNamed("Debate - Bong.mp3", waitForCompletion: false))
        bidenSoundArray.append(SKAction.playSoundFileNamed("Debate - Biden1.mp3", waitForCompletion: true))
        bidenSoundArray.append(SKAction.playSoundFileNamed("Debate - Biden2.mp3", waitForCompletion: true))
        bidenSoundArray.append(SKAction.playSoundFileNamed("Debate - Biden3.mp3", waitForCompletion: true))
        bidenSoundArray.append(SKAction.playSoundFileNamed("Debate - Biden4.mp3", waitForCompletion: true))
        bidenSoundArray.append(SKAction.playSoundFileNamed("Debate - Biden5.mp3", waitForCompletion: true))
        bidenSoundArray.shuffle()
                
        startGame()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if !tileArr.isEmpty && tileArr[0].position.y < -self.size.height - 100 {
            tileArr[0].remove()
            if tileArr[0].touched {
                tileArr.remove(at: 0)
            }
        }
        
        if waveCounter >= waveLength {
            wave += 1
            waveLength += 10
            waveCounter = 0
            
            timer.invalidate()
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) {_ in
                self.nextWave()
            }
        }
        
        scoreLabel.text = "Liberal Tears: \(score)"
    }
    
    @objc func addTile() {
        if gameOverScreen.isHidden {
            let lane = randomLane()
            totalTiles += 1
            let tile = Tile(debateScene: self, lane: lane, id: totalTiles - 1)
            tileArr.append(tile)
            addChild(tile)
        } else {
            timer.invalidate()
        }
        
    }
    
    func nextWave() {
        trumpSprite.run(SKAction.fadeAlpha(to: 0.3, duration: 0.5))
        trumpSprite.run(SKAction.scale(to: 1.0, duration: 0.5))
        bidenSprite.run(SKAction.fadeAlpha(to: 1.0, duration: 0.5))
        bidenSprite.run(SKAction.scale(to: 1.5, duration: 0.5))
        let bidenSound = bidenSoundArray[bidenSoundIndex % bidenSoundArray.count]
        self.run(bidenSound)
        bidenSoundIndex += 1
        
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) {_ in
            self.trumpSprite.run(SKAction.fadeAlpha(to: 1.0, duration: 0.5))
            self.trumpSprite.run(SKAction.scale(to: 1.5, duration: 0.5))
            self.bidenSprite.run(SKAction.fadeAlpha(to: 0.3, duration: 0.5))
            self.bidenSprite.run(SKAction.scale(to: 1.0, duration: 0.5))
            
            self.tileDuration -= pow(Double(initialDurationDecrement), Double(self.wave))
            let speed = (self.size.height + self.size.height / relativeTileHeight) / CGFloat(self.tileDuration)
            let timerInterval = TimeInterval((self.size.height / relativeTileHeight) / speed)
            self.timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(self.addTile), userInfo: nil, repeats: true)
        }
    }
    
    func playBackgroundMusic() {
        //bgMusicNode.autoplayLooped = true
        //addChild(bgMusicNode)
    }
    
    func playRandomTileSound() {
        let randIndex = Int(arc4random() % UInt32(soundActionArray.count))
        self.run(soundActionArray[randIndex])
    }
    
    func gameLost() {
        timer.invalidate()
        self.bgMusicNode.removeFromParent()
        self.removeAllActions()

        for i in 0..<tileArr.count {
            tileArr[i].removeAction(forKey: "move")
            tileArr[i].isUserInteractionEnabled = false
        }
        
        if score > gameOverScreen.highScore {
            gameOverScreen.saveNewHighscore(newHighscore: score)
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            self.scoreLabel.isHidden = true
            self.gameOverScreen.isHidden = false
            self.gameOverScreen.scoreLabel.text = "Tears collected: \(self.score)"
        }
    }
    
    func startGame() {
        playBackgroundMusic()
        
        for tile in self.tileArr {
            tile.removeFromParent()
        }
        self.tileArr.removeAll()
        
        scoreLabel.isHidden = false
        gameOverScreen.isHidden = true
        score = 0
        wave = 1
        waveLength = 20
        waveCounter = 0
        tileDuration = Double(tileStartDuration)
        lastIdTouched = -1
        totalTiles = 0
        
        nextWave()
    }
    
    func returnToGameSelect() {
        let timePlayed = CFAbsoluteTimeGetCurrent() - startTime
        saveTimePlayed(timePlayed: timePlayed)
        
        let gameSelectScene = GameSelectScene(size: self.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(gameSelectScene, transition: transition)
    }
    
    func randomLane() -> Int {
        return Int(arc4random() % 4)
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
}

