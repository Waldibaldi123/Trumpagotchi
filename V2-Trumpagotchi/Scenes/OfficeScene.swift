//
//  OfficeScene.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/29/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

class OfficeScene: SKScene {
    var tutorialPoint = "none"
    var tutorialStarted = false
    var gameRestart = false
    var briefingDone = false
    var currentDraggedTweet: TweetPile!
    
    var trump: Trump!
    var pathFinder: PathFinder!
    
    var background: Background!
    var desk: Desk!
    var television: Television!
    var briefing: Briefing!
    var nuclearSuitcase: NuclearSuitcase!
    var tweetPiles: [TweetPile] = []
    
    var meters: Meters!
    var cokeBottle: CokeBottle!
    var trashBin: TrashBin!
    var tutorialBox: TutorialBox!
    var exit: Exit!
    var miniGameTimePlayed: CFAbsoluteTime!
    var devAvatar: DevAvatar!
    
    override func didMove(to view: SKView) {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "lastAppOpenTime") == false {
            setStartDefaults()
            initializeRoom()
            initializeTrump()
            initializeInterface()
            setUpStartSequence()
        } else {
            initializeRoom()
            initializeTrump()
            initializeInterface()
        }
        
        reloadGameData()
        
        if briefingDone {
            self.devAvatar.showAvatar(title: briefingComment["title"] ?? "", source: briefingComment["source"] ?? "", text: briefingComment["text"] ?? "", texture: briefing.texture!)
            self.briefing.lastReadTime = CFAbsoluteTimeGetCurrent()
            self.trump.changeDisciplineMeter(value: 50)
            briefingDone = false
            
            if tutorialPoint == "briefingTutorial" {
                tutorialPoint = "lastWords"
                tutorialBox.setText(text: "Alright, I think you are ready to take on the Trump. I shall run away as far as possible, peace out.")
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) {_ in
                    self.tutorialPoint = "none"
                    self.tutorialBox.setText(text: "")
                    self.tutorialBox.isHidden = true
                }
            }
        } else if tutorialPoint == "briefingTutorial" {
            tutorialBox.setText(text: "Thank god, you came back! Trump's natural enemies are scientists and books, but if he doesn't read his briefings, bad things happen. A little hint: be fast.")
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveGameData), name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(reloadGameData), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func update(_ currentTime: TimeInterval) {
        trump.update()
        briefing.update()
        meters.update()
        background.update()
        television.update()
        if tutorialPoint != "none" {
            tutorialBox.isHidden = false
            updateTutorial()
        } else {
            tutorialBox.isHidden = true
        }
    }
    
    //MARK: - User Interaction
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if tutorialPoint == "wakeUpTutorial"  && !tutorialStarted{
            tutorialStarted = true
            trump.stateMachine.enter(IdleState.self)
            trump.isUserInteractionEnabled = true
            self.camera?.removeFromParent()
            
            self.tutorialBox.setText(text: "...no I tell you, I cannot handle him anymore!")
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) {_ in
                self.tutorialBox.setText(text: "...")
            }
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) {_ in
                self.tutorialBox.setText(text: "Oh hello. You must be my replacement. I'd say welcome to hell, but that's an understatement considering what you will go trough.")
            }
            Timer.scheduledTimer(withTimeInterval: 8.0, repeats: false) {_ in
                self.tutorialBox.setText(text: "Oh no, oh god, Trump ran out of his beloved Diet-Coke! Fast, restock cans before he takes his anger out on the rest of us!")
                self.trump.stateMachine.enter(CokeState.self)
                self.tutorialPoint = "cokeTutorial"
            }
        } else if let touch = touches.first {
            let location = touch.location(in: self)
            if !(cokeBottle.contains(location) && !cokeBottle.isHidden) && pathFinder.pointIsWalkable(point: location) && trump.stateMachine.currentState is IdleState {
                trump.run(trump.walk(dest: location))
                //print(location.x / UIScreen.main.bounds.size.width)
                //print(location.y / UIScreen.main.bounds.size.height)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if (cokeBottle.contains(location) || cokeBottle.isMoving) && !cokeBottle.isHidden {
                cokeBottle.moveTo(location: location)
            } else {
                for tweetPile in tweetPiles {
                    if tweetPile.contains(location) && currentDraggedTweet == nil {
                        currentDraggedTweet = tweetPile
                        trashBin.isHidden = false
                    }
                }
            }
            
            if currentDraggedTweet != nil {
                currentDraggedTweet.moveTo(location: location)
                currentDraggedTweet.showTweet()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if cokeBottle.contains(location) && desk.contains(location) {
                desk.changeCokeAmount(value: 1)
                cokeBottle.resetPosition(screenSize: self.size)
            } else if cokeBottle.contains(location) && trump.contains(location) && (trump.stateMachine.currentState is IdleState || trump.stateMachine.currentState is NuclearState || trump.stateMachine.currentState is WatchTVState) {
                if trump.stateMachine.currentState is NuclearState {
                    trump.stateMachine.enter(IdleState.self)
                }
                trump.run(trump.drink())
                cokeBottle.resetPosition(screenSize: self.size)
            } else {
                cokeBottle.moveToResetPosition(screenSize: self.size)
            }
            
            if currentDraggedTweet != nil {
                if currentDraggedTweet.contains(location) && trashBin.contains(location) {
                    currentDraggedTweet.throwAway()
                } else {
                    currentDraggedTweet.tweetPost.isHidden = true
                }
                currentDraggedTweet = nil
                trashBin.isHidden = true
            }
        }
    }
    
    //MARK: - Data Management
    
    func setStartDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(CFAbsoluteTimeGetCurrent(), forKey: "lastAppOpenTime")
        defaults.set(0, forKey: "deskCokeAmount")
        defaults.set(false, forKey: "televisionIsOn")
        defaults.set(CFAbsoluteTimeGetCurrent(), forKey: "briefingLastReadTime")
        defaults.set(0, forKey: "trumpAngryMeter")
        defaults.set(100, forKey: "trumpDisciplineMeter")
        defaults.set(0, forKey: "trumpTiredMeter")
        defaults.set(0, forKey: "trumpNumTweets")
        defaults.set(0, forKey: "timePlayed")
        defaults.set(0, forKey: "debateHighscore")
        defaults.set(0, forKey: "covidHighscore")
        defaults.set(0, forKey: "conferenceHighscore")
        defaults.set("wakeUpTutorial", forKey: "tutorialPoint")
        defaults.set(CFAbsoluteTimeGetCurrent(), forKey: "startTime")
    }
    
    @objc func saveGameData() {
        desk.saveData()
        television.saveData()
        briefing.saveData()
        trump.saveData()
        UserDefaults.standard.set(CFAbsoluteTimeGetCurrent(), forKey: "lastAppOpenTime")
        UserDefaults.standard.set(tutorialPoint, forKey: "tutorialPoint")
        
        scheduleNotifications()
    }
    
    @objc func reloadGameData() {
        desk.loadData()
        television.loadData()
        briefing.loadData()
        trump.loadData()
        if tutorialPoint == "none" {
            tutorialPoint = UserDefaults.standard.string(forKey: "tutorialPoint")!
        } 
    }
    
    func scheduleNotifications() {
        scheduleNotificationWith(body: angry100Body, intervalInSeconds: trump.timeTo100Angry())
        scheduleNotificationWith(body: discipline0Body, intervalInSeconds: trump.timeTo0Discipline())
        if television.isOn && trump.stateMachine.currentState is SleepState {
            scheduleNotificationWith(body: tired0Body, intervalInSeconds: trump.timeTo0Tired())
        }
        
        scheduleNotificationWith(body: angryLooseBody, intervalInSeconds: trump.timeToAngryLose() * 0.7)
        scheduleNotificationWith(body: disciplineLooseBody, intervalInSeconds: trump.timeToDisciplineLose() * 0.7)
    }
    
    //MARK: - Initiliazation
    
    func initializeRoom() {
        let screenSize = UIScreen.main.bounds.size
        
        let background = Background(screenSize: screenSize, officeScene: self)
        addChild(background)
        self.background = background
        
        let extendedBackground = SKShapeNode(rect: CGRect(x: 0, y: 0, width: screenSize.width, height: 300))
        extendedBackground.fillColor = UIColor(cgColor: CGColor(srgbRed: 196/255, green: 193/255, blue: 163/255, alpha: 1))
        addChild(extendedBackground)
        
        let desk = Desk(screenSize: screenSize, officeScene: self)
        addChild(desk)
        self.desk = desk
        
        let briefing = Briefing(screenSize: screenSize, officeScene: self)
        addChild(briefing)
        self.briefing = briefing
        
        let cokeButton = CokeButton(screenSize: screenSize, officeScene: self)
        addChild(cokeButton)
        
        let trophy = Trophy(screenSize: screenSize, officeScene: self)
        addChild(trophy)
        
        let television = Television(screenSize: screenSize, officeScene: self)
        addChild(television)
        self.television = television
        
        let flagRight = FlagRight(screenSize: screenSize)
        addChild(flagRight)
        
        let flagLeft = FlagLeft(screenSize: screenSize)
        addChild(flagLeft)
        
        let curtain = Curtain(screenSize: screenSize)
        addChild(curtain)
        
        //let chair = Chair(screenSize: screenSize)
        //addChild(chair)
        
        let smallTable = SmallTable(screenSize: screenSize)
        addChild(smallTable)
        
        let nuclearSuitcase = NuclearSuitcase(screenSize: screenSize)
        addChild(nuclearSuitcase)
        self.nuclearSuitcase = nuclearSuitcase
        
        //let piggyBank = PiggyBank(screenSize: screenSize, officeScene: self)
        //addChild(piggyBank)
    }
    
    func initializeTrump() {
        let pathFinder = PathFinder(officeScene: self)
        self.pathFinder = pathFinder
        
        let trump = Trump(officeScene: self)
        addChild(trump)
        self.trump = trump
    }
    
    func initializeInterface() {
        let screenSize = UIScreen.main.bounds.size

        let meters = Meters(officeScene: self, trump: trump)
        addChild(meters)
        self.meters = meters
        
        let exit = Exit(officeScene: self)
        addChild(exit)
        self.exit = exit
        
        let cokeBottle = CokeBottle(screenSize: screenSize)
        addChild(cokeBottle)
        self.cokeBottle = cokeBottle
        
        let trashBin = TrashBin(screenSize: screenSize)
        addChild(trashBin)
        self.trashBin = trashBin
        
        let tutorialBox = TutorialBox(screenSize: screenSize, text: "")
        addChild(tutorialBox)
        self.tutorialBox = tutorialBox
        
        let devAvatar = DevAvatar(screenSize: screenSize)
        addChild(devAvatar)
        self.devAvatar = devAvatar
    }
    
    //MARK: - Transitions
    
    func transitionToMinigame() {
        self.saveGameData()
        let transition = SKTransition.fade(withDuration: 0.5)
        let debateScene = GameSelectScene(size: self.size)
        self.view?.presentScene(debateScene, transition: transition)
    }
    
    func transitionToBriefing() {
        self.saveGameData()
        let transition = SKTransition.fade(withDuration: 0.5)
        let briefingScene = BriefingScene(size: self.size)
        self.view?.presentScene(briefingScene, transition: transition)
    }
    
    //MARK: - Tutorial
    
    func setUpStartSequence() {
        tutorialPoint = "wakeUpTutorial"
        exit.isHidden = true
        television.isUserInteractionEnabled = false
        trump.isUserInteractionEnabled = false
        
        
        trump.stateMachine.enter(LazyState.self)
        let cam = SKCameraNode()
        self.camera = cam
        cam.position = CGPoint(x: trump.position.x, y: trump.position.y + trump.size.height * 0.6)
        cam.setScale(0.4)
        addChild(cam)
    }
    
    func updateTutorial() {
        if tutorialPoint == "cokeTutorial" && trump.stateMachine.currentState is IdleState {
            tutorialPoint = "typingTweetTutorial"
            trump.run(trump.typeTweet())
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) {_ in
                self.tutorialBox.setText(text: "Oh yeah, did I already mention that you will have to constantly clean up after him? Believe me, without us there would be even worse stuff coming out of his phone...")
                self.tutorialPoint = "tweetTutorial"
            }
        } else if tutorialPoint == "tweetTutorial" && trump.numTweets != 0 {
            tutorialBox.setText(text: "Oh yeah, did I already mention that you will have to constantly clean up after him? Believe me, without us there would be even worse stuff coming out of his phone...")
        } else if tutorialPoint == "tweetTutorial" && trump.numTweets == 0 {
            tutorialPoint = "playTutorial"
            tutorialBox.setText(text: "Trump craves attention, and he will destroy the world to get it. Better take him outside instead to shout at some reporters or something.")
            exit.isHidden = false
        } else if tutorialPoint == "playTutorial" {
            tutorialBox.setText(text: "Trump craves attention, and he will destroy the world to get it. Better take him outside instead to shout at some reporters or something.")
        } else if tutorialPoint == "sleepTutorial" && !television.isOn {
            trump.tiredMeter = 100
            tutorialBox.setText(text: "...no I tell you, I cannot handle him - Oh you survived, that's a first! Luckily you made Trump tired, so best send him to sleep now!")
            television.isUserInteractionEnabled = true
        } else if tutorialPoint == "sleepTutorial" && television.isOn && !(trump.stateMachine.currentState is LazyState) {
            tutorialBox.setText(text: "Ahhhh. Isn't it beautiful to get a short break of him? He is going to be out for a couple of hours. Enough time to see my therapist...")
            television.isUserInteractionEnabled = false
        } else if tutorialPoint == "sleepTutorial" {
            television.isUserInteractionEnabled = true
            briefing.makeAvailable()
            tutorialPoint = "briefingTutorial"
            tutorialBox.setText(text: "Thank god, you came back! Trump's natural enemies are scientists and books, but if he doesn't read his briefings, bad things happen. A little hint: be fast.")
        }
    }
    
    //MARK: - GameOver Animations
    
    func playNuclearExplosion() {
        let light = SKShapeNode(rect: CGRect(x: -5, y: 0, width: self.size.width + 10, height: self.size.height))
        light.fillColor = UIColor.white
        light.alpha = 0.0
        light.zPosition = 200
        addChild(light)
        
        let dark = SKShapeNode(rect: CGRect(x: -5, y: 0, width: self.size.width + 10, height: self.size.height))
        dark.fillColor = UIColor.black
        dark.alpha = 0.0
        dark.zPosition = 201
        addChild(dark)
    
        light.run(SKAction.fadeAlpha(to: 1.0, duration: 0.5))
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {_ in
            dark.run(SKAction.fadeAlpha(to: 1.0, duration: 1.5))
        }
    }
    
    func playPoliceComing() {
        let redLight = SKShapeNode(rect: CGRect(x: -5, y: 0, width: self.size.width + 10, height: self.size.height))
        redLight.fillColor = UIColor.red
        redLight.alpha = 0.0
        redLight.zPosition = 200
        addChild(redLight)
        
        let blueLight = SKShapeNode(rect: CGRect(x: -5, y: 0, width: self.size.width + 10, height: self.size.height))
        blueLight.fillColor = UIColor.blue
        blueLight.alpha = 0.0
        blueLight.zPosition = 200
        addChild(blueLight)
        
        var intensity = CGFloat(0)
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
            intensity = intensity <= 0.4 ? intensity + 0.1 : intensity
            redLight.run(SKAction.sequence([SKAction.fadeAlpha(to: intensity, duration: 0.5), SKAction.fadeAlpha(to: 0.0, duration: 0.5)]))
        }
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
            intensity = intensity <= 0.6 ? intensity + 0.1 : intensity
            blueLight.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.0, duration: 0.5), SKAction.fadeAlpha(to: intensity, duration: 0.5)]))
        }
    }
    
    func transitionToGameOverScreen(reason: String) {
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameOverScene = GameOverScene(size: self.size)
        gameOverScene.gameOverImageName = reason
        self.view?.presentScene(gameOverScene, transition: transition)
    }
}
