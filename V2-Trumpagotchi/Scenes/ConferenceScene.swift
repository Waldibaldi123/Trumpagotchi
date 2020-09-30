//
//  ConferenceScene.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/18/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

class ConferenceScene: SKScene {
    let startTime = CFAbsoluteTimeGetCurrent()
    
    var score = 0
    let scoreLabel = SKLabelNode()
    var gameOverScreen: ConferenceGameOver!
    
    var sequence: [Int] = []
    var currentSeqPos = -1
    var playingSeq = true
    
    var background = SKSpriteNode(texture: SKTexture(imageNamed: "conference_background"))
    var reporters: [SKSpriteNode] = []
    var trump: SKSpriteNode!
    var trumpSounds: [SKAction] = []
    var reporterSounds: [SKAction] = []
    let audioNode = SKAudioNode()
    
    override func didMove(to view: SKView) {
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - Not you.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - Organization1.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - Organization2.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - Quiet.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - Rude1.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - Rude2.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - Question.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - FakeNews.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - Run country.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - Enough1.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - Enough2.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - CNN1.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - CNN2.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - Sit down.mp3", waitForCompletion: true))
        trumpSounds.append(SKAction.playSoundFileNamed("Conference - CNN3.mp3", waitForCompletion: true))

        reporterSounds.append(SKAction.playSoundFileNamed("Conference - Reporter1.mp3", waitForCompletion: false))
        reporterSounds.append(SKAction.playSoundFileNamed("Conference - Reporter2.mp3", waitForCompletion: false))
        reporterSounds.append(SKAction.playSoundFileNamed("Conference - Reporter3.mp3", waitForCompletion: false))
        reporterSounds.append(SKAction.playSoundFileNamed("Conference - Reporter4.mp3", waitForCompletion: false))
        reporterSounds.append(SKAction.playSoundFileNamed("Conference - Reporter5.mp3", waitForCompletion: false))
        reporterSounds.append(SKAction.playSoundFileNamed("Conference - Reporter6.mp3", waitForCompletion: false))
        reporterSounds.append(SKAction.playSoundFileNamed("Conference - Reporter7.mp3", waitForCompletion: false))
        reporterSounds.append(SKAction.playSoundFileNamed("Conference - Reporter8.mp3", waitForCompletion: false))
        reporterSounds.append(SKAction.playSoundFileNamed("Conference - Reporter9.mp3", waitForCompletion: false))

        self.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 134/255, green: 134/255, blue: 134/255, alpha: 1.0))
        
        background.size = self.size
        background.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.63)
        addChild(background)
        
        NotificationCenter.default.addObserver(self, selector: #selector(enteredBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        setupReporters()
        setupTrump()
        
        self.gameOverScreen = ConferenceGameOver(conferenceScene: self)
        addChild(gameOverScreen)
        
        addChild(audioNode)
        
        scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        scoreLabel.fontColor = UIColor.black
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.position = CGPoint(x: self.size.width * 0.95, y: self.size.height * 0.95)
        addChild(scoreLabel)
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {_ in
            self.startGame()

        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil && !playingSeq {
            let location = touches.first!.location(in: self)
            for i in 0..<reporters.count {
                if reporters[i].contains(location) {
                    playReporter(index: i)
                    if sequence[currentSeqPos] == i {
                        currentSeqPos += 1
                    } else {
                        gameOver()
                    }
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if currentSeqPos == sequence.count {
            score += 1
            currentSeqPos = 0
            trump.run(trumpSmile())
            trump.run(playTrumpSound(), completion: {() -> Void in
                self.trump.removeAllActions()
                self.playSequence()
            })
        }
        
        scoreLabel.text = "\(score)"
    }
    
    func gameOver() {
        playingSeq = true
        
        if score > gameOverScreen.highScore {
            gameOverScreen.saveNewHighscore(newHighscore: score)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            self.scoreLabel.isHidden = true
            self.gameOverScreen.isHidden = false
            self.gameOverScreen.scoreLabel.text = "FakeNews called out: \(self.score)"
        }
    }
    
    func startGame() {
        score = 0
        sequence = []
        currentSeqPos = 0
        playingSeq = true
        playSequence()
    }
    
    func returnToGameSelect() {
        let timePlayed = CFAbsoluteTimeGetCurrent() - startTime
        saveTimePlayed(timePlayed: timePlayed)
        
        let officeScene = GameSelectScene(size: self.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(officeScene, transition: transition)
    }
    
    func playSequence() {
        playingSeq = true
        let newReporter = Int(arc4random() % 9)
        sequence.append(newReporter)
        
        for i in 0..<sequence.count {
            Timer.scheduledTimer(withTimeInterval: Double(i), repeats: false) {_ in
                let index = self.sequence[i]
                self.playReporter(index: index)
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: Double(sequence.count), repeats: false) {_ in
            self.playingSeq = false
        }
    }
    
    func playReporter(index: Int) {
        let reporter = reporters[index]
        let atlasName = "ReporterHand\(index + 1)"
        reporter.removeAllActions()
        reporter.run(animateNode(textureAtlas: SKTextureAtlas(named: atlasName), timePerFrame: 0.3, timeOfAnimation: 0.6))
        let soundAction = reporterSounds[index]
        audioNode.run(soundAction)
    }
    
    func setupReporters() {
        let reporterTexture = SKTexture(imageNamed: "reporter1")
        let reporterSize = CGSize(width: self.size.width * 0.25, height: ((self.size.width * 0.25) / reporterTexture.size().width) * reporterTexture.size().height)
        for i in 0..<9 {
            reporters.append(SKSpriteNode(texture: reporterTexture, size: reporterSize))
            reporters[i].texture = SKTexture(imageNamed: "reporter\(i+1)")
            
            var reporterPos = CGPoint()
            switch i {
            case 0:
                reporterPos = CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.2)
                reporters[i].zPosition = 4
            case 1:
                reporterPos = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.2)
                reporters[i].zPosition = 4
            case 2:
                reporterPos = CGPoint(x: self.size.width * 0.8, y: self.size.height * 0.2)
                reporters[i].zPosition = 4
            case 3:
                reporterPos = CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.4)
                reporters[i].zPosition = 3
            case 4:
                reporterPos = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.4)
                reporters[i].zPosition = 3
            case 5:
                reporterPos = CGPoint(x: self.size.width * 0.8, y: self.size.height * 0.4)
                reporters[i].zPosition = 3
            case 6:
                reporterPos = CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.6)
                reporters[i].zPosition = 2
            case 7:
                reporterPos = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.6)
                reporters[i].zPosition = 2
            case 8:
                reporterPos = CGPoint(x: self.size.width * 0.8, y: self.size.height * 0.6)
                reporters[i].zPosition = 2
            default:
                break
            }
            
            reporters[i].position = reporterPos
            addChild(reporters[i])
        }
    }
    
    func setupTrump() {
        let trumpTexture = SKTexture(imageNamed: "trumpPodium")
        let trumpSize = CGSize(width: self.size.width * 0.3, height: ((self.size.width * 0.3) / trumpTexture.size().width) * trumpTexture.size().height)
        self.trump = SKSpriteNode(texture: trumpTexture, size: trumpSize)
        trump.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.83)
        trump.zPosition = 1
        addChild(trump)
    }
    
    @objc func enteredBackground() {
        returnToGameSelect()
    }
    
    func saveTimePlayed(timePlayed: Double) {
        let oldTimePlayed = UserDefaults.standard.double(forKey: "timePlayed")
        UserDefaults.standard.set(timePlayed + oldTimePlayed, forKey: "timePlayed")
    }
    
    func trumpSmile() -> SKAction {
        return animateNode(textureAtlas: SKTextureAtlas(named: "trumpPodiumSmile"), timePerFrame: 1.0, timeOfAnimation: 0)
    }
    
    func playTrumpSound() -> SKAction {
        return trumpSounds[(score - 1) % trumpSounds.count]
    }
}
