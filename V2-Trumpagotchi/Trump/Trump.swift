//
//  Trump.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 8/2/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Trump: SKSpriteNode {
    //scene reference
    var officeScene: OfficeScene!
    
    //meters
    var angryMeter: Int!
    var disciplineMeter: Int!
    var tiredMeter: Int!
    
    //helper fields
    var lastPosition: CGPoint!
    var numTweets: Int = 0
    
    //state machine
    var stateMachine: GKStateMachine!
    
    init(officeScene: OfficeScene) {
        self.officeScene = officeScene
        
        let texture = SKTexture(imageNamed: "trump-standing")
        let scaleRatio = (officeScene.size.width / scaleToScreenDict["trumpMAX"]!) / texture.size().width
        let spriteSize = CGSize(width: officeScene.size.width / scaleToScreenDict["trumpMAX"]!, height: texture.size().height * scaleRatio)
        super.init(texture: texture, color: UIColor.clear, size: spriteSize)
        
        //let screenRatio = String(Double(floor(100 * (officeScene.size.height / officeScene.size.width)) / 100))
        self.anchorPoint = CGPoint(x: 0.5, y: 0.1)
        self.position = CGPoint(x: officeScene.size.width * relativeSleepPoint.x, y: officeScene.size.height * relativeSleepPoint.y)
        self.zPosition = 30
        self.isUserInteractionEnabled = true
        lastPosition = self.position
        
        self.stateMachine = GKStateMachine(states: [
            CokeState(scene: self.officeScene, trump: self),
            IdleState(scene: self.officeScene, trump: self),
            WatchTVState(scene: self.officeScene, trump: self),
            SleepState(scene: self.officeScene, trump: self),
            LazyState(scene: self.officeScene, trump: self),
            NuclearState(scene: self.officeScene, trump: self),
            DictatorState(scene: self.officeScene, trump: self)
        ])
        stateMachine.enter(IdleState.self)
        
        loadData()
        
        for _ in 0..<numTweets {
            let tweet = TweetPile(screenSize: officeScene.size, startPos: self.position, endPos: officeScene.pathFinder.getRandomTweetPoint(), officeScene: officeScene)
            officeScene.addChild(tweet)
        }
    }
    
    func update() {
        stateMachine.currentState?.update(deltaTime: 0)
        updateSprite()
        
        if angryMeter == 100 && !(self.stateMachine.currentState is NuclearState) {
            stateMachine.enter(NuclearState.self)
        }
    }
    
    //MARK: - User Interaction
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if stateMachine.currentState is LazyState {
            officeScene.devAvatar.showAvatar(title: lazyTrumpComment["title"] ?? "", source: lazyTrumpComment["source"] ?? "", text: lazyTrumpComment["text"] ?? "", texture: self.texture!)
        }
        
        if stateMachine.currentState is IdleState {
            self.run(touched())
        } else if stateMachine.currentState is LazyState {
            stateMachine.enter(IdleState.self)
        }
    }
    
    //MARK: - Meter Logic
    
    func changeAngryMeter(value: Int) {
        angryMeter += value
        angryMeter = angryMeter > 100 ? 100 : angryMeter
        angryMeter = angryMeter < 0 ? 0 : angryMeter
    }
    
    func changeDisciplineMeter(value: Int) {
        disciplineMeter += value
        disciplineMeter = disciplineMeter > 100 ? 100 : disciplineMeter
        disciplineMeter = disciplineMeter < 0 ? 0 : disciplineMeter
    }
    
    func changeTiredMeter(value: Int) {
        tiredMeter += value
        tiredMeter = tiredMeter > 100 ? 100 : tiredMeter
        tiredMeter = tiredMeter < 0 ? 0 : tiredMeter
    }
    
    func changeNumTweets(value: Int) {
        if value > 0 && numTweets + value <= 5 {
            for _ in 0..<value {
                let tweet = TweetPile(screenSize: officeScene.size, startPos: self.position, endPos: officeScene.pathFinder.getRandomTweetPoint(), officeScene: officeScene)
                officeScene.addChild(tweet)
                changeDisciplineMeter(value: -10)
            }
        } else if value > 0 {
            for _ in 0..<(5-numTweets) {
                let tweet = TweetPile(screenSize: officeScene.size, startPos: self.position, endPos: officeScene.pathFinder.getRandomTweetPoint(), officeScene: officeScene)
                officeScene.addChild(tweet)
                changeDisciplineMeter(value: -10)
            }
        } else if value < 0 {
            changeDisciplineMeter(value: 10)
        }
        
        numTweets += value
        numTweets = numTweets > 5 ? 5 : numTweets
        numTweets = numTweets < 0 ? 0 : numTweets
    }
    
    //MARK: - Data Management
    
    func loadData() {
        let defaults = UserDefaults.standard
        angryMeter = defaults.integer(forKey: "trumpAngryMeter")
        disciplineMeter = defaults.integer(forKey: "trumpDisciplineMeter")
        tiredMeter = defaults.integer(forKey: "trumpTiredMeter")
        numTweets = defaults.integer(forKey: "trumpNumTweets")
        let lastAppOpenTime = defaults.double(forKey: "lastAppOpenTime")
        let timePassed = CFAbsoluteTimeGetCurrent() - lastAppOpenTime
        
        //check for time played
        let timePlayed = defaults.double(forKey: "timePlayed")
        defaults.set(0, forKey: "timePlayed")
        changeTiredMeter(value: Int(timePlayed / tiredPlayIncInterval))
        changeAngryMeter(value: -Int(timePlayed / angryPlayDecInterval))
        
        let tutorialPoint = defaults.string(forKey: "tutorialPoint")!
        if timePlayed > 0 && tutorialPoint == "playTutorial" {
            tiredMeter = 100
            officeScene.tutorialPoint = "sleepTutorial"
        }
       
        changeAngryMeter(value: getAngryInc(timePassed: timePassed))
        changeDisciplineMeter(value: getDisciplineDec(timePassed: timePassed))
        changeTiredMeter(value: getTiredInc(timePassed: timePassed))
        
        let addedTweets = Int(timePassed / tweetInterval)
        changeNumTweets(value: addedTweets)
        
        if timePassed > timeToAngryLose() {
            self.stateMachine.enter(NuclearState.self)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {_ in
                self.run(SKAction.sequence([self.pressNuclearButton(), self.pressNuclearButton()]))
            }
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) {_ in
                self.officeScene.playNuclearExplosion()
            }
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) {_ in
                self.officeScene.transitionToGameOverScreen(reason: "nuclearExplosion")
            }
        } else if timePassed > timeToDisciplineLose() {
            self.stateMachine.enter(DictatorState.self)
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) {_ in
                self.officeScene.transitionToGameOverScreen(reason: "policeComing")
            }
        }
        
        saveData()
    }
    
    func saveData() {
        let defaults = UserDefaults.standard
        defaults.set(angryMeter, forKey: "trumpAngryMeter")
        defaults.set(disciplineMeter, forKey: "trumpDisciplineMeter")
        defaults.set(tiredMeter, forKey: "trumpTiredMeter")
        defaults.set(numTweets, forKey: "trumpNumTweets")
    }
        
    func getAngryInc(timePassed: Double) -> Int {
        var angryInc = Int(timePassed / angryIncInterval)
        
        if officeScene.television.isOn {
            angryInc -= Int(timePassed / angryWatchTVDecInterval)
        }
        
        var cokeDrunk = Int(timePassed / drinkInterval)
        if cokeDrunk > officeScene.desk.cokeAmount {
            cokeDrunk = officeScene.desk.cokeAmount
        }
        angryInc -= cokeDrunk * 10
        
        return angryInc
    }
    
    func timeTo100Angry() -> Double {
        let angryMissing = 100 - angryMeter
        var incInterval = angryIncInterval
        
        if officeScene.television.isOn {
            incInterval += (incInterval / angryWatchTVDecInterval) * (incInterval * 2)
        }
        
        var timeTo100 = Double(angryMissing) * incInterval
        var cokeDrunk = Int(timeTo100 / drinkInterval)
        if cokeDrunk > officeScene.desk.cokeAmount {
            cokeDrunk = officeScene.desk.cokeAmount
        }
        timeTo100 += Double(cokeDrunk) * drinkInterval
        
        if timeTo100 == 0 {
            timeTo100 = 1
        }
        return timeTo100
    }
    
    func timeToAngryLose() -> Double {
        let timeTo100 = timeTo100Angry()
        let timeToLose = timeTo100 + angryLoseInterval
        return timeToLose
    }
    
    func getDisciplineDec(timePassed: Double) -> Int {
        var disciplineDec = -Int(timePassed / disciplineDecInterval)
        if officeScene.television.isOn {
            disciplineDec -= Int(timePassed / disciplineWatchTVDecInterval)
        }
        
        return disciplineDec
    }
    
    func timeTo0Discipline() -> Double {
        let disciplineAvailable = disciplineMeter!
        var decInterval = disciplineDecInterval
        
        if officeScene.television.isOn {
            decInterval -= (decInterval / disciplineWatchTVDecInterval) * (decInterval / 2)
        }
        
        var timeTo0 = Double(disciplineAvailable) * decInterval
        
        if timeTo0 == 0 {
            timeTo0 = 1
        }
        return timeTo0
    }
    
    func timeToDisciplineLose() -> Double {
        let timeTo0 = timeTo0Discipline()
        let timeToLose = timeTo0 + disciplineLoseInterval
        return timeToLose
    }
    
    func getTiredInc(timePassed: Double) -> Int {
        var tiredInc = 0
        if officeScene.television.isOn {
            tiredInc -= Int(timePassed / tiredDecInterval)
        } else {
            tiredInc += Int(timePassed / tiredIncInterval)
        }
        
        //enter appropiate state
        if tiredInc < 0 {
            stateMachine.enter(SleepState.self)
        }
        
        return tiredInc
    }
    
    func timeTo0Tired() -> Double {
        let tiredAvailable = tiredMeter!
        let decInterval = tiredDecInterval
        
        var timeTo0 = Double(tiredAvailable) * decInterval
        
        if timeTo0 == 0 {
            timeTo0 = 1
        }
        return timeTo0
    }
    
    //MARK: - Update Functions
    
    func updateSprite() {
        if self.position.y > officeScene.desk.position.y - 1 {
            self.zPosition = 15
        } else if self.position.y > officeScene.television.position.y - 1 {
            self.zPosition = 25
        } else {
            self.zPosition = 35
        }
        
        if stateMachine.currentState is SleepState || stateMachine.currentState is LazyState || stateMachine.currentState is NuclearState {
            //size handled in the state
        } else {
            self.size = newSize(currentY: self.position.y)
        }
        
        orientTrump()
        lastPosition = self.position
    }
    
    func newSize(currentY: CGFloat) -> CGSize {
        let maxScale = scaleToScreenDict["trumpMAX"]!
        let minScale = scaleToScreenDict["trumpMIN"]!
        let newScale = (maxScale - minScale) * (1 - currentY / officeScene.size.height) + minScale
        if self.texture == nil {
            self.texture = SKTexture(imageNamed: "trump-standing")
        }
        let scaleRatio = (officeScene.size.width / newScale) / self.texture!.size().width
        let newSize = CGSize(width: officeScene.size.width / newScale, height: self.texture!.size().height * scaleRatio)
        return newSize
    }
    
    func orientTrump() {
        var multiplierForDirection: CGFloat
        let xDiff = CGFloat(lastPosition.x - self.position.x)
        
        if xDiff < 0 {
            multiplierForDirection = -1.0
        } else {
            multiplierForDirection = 1.0
        }
        self.xScale = abs(self.xScale) * multiplierForDirection
    }
    
    //MARK: - Animations
    
    func walk(dest: CGPoint) -> SKAction {
        self.removeAllActions()
        let path = officeScene.pathFinder.buildPath(start: self.position, dest: dest)
        let moveAction = SKAction.sequence([SKAction.follow(path.cgPath, asOffset: true, orientToPath: false, speed: 200.0), removeAction(key: "walkAnimation")])
        self.run(animateNode(textureAtlas: SKTextureAtlas(named: "trumpWalk"), timePerFrame: 0.3, timeOfAnimation: 0), withKey: "walkAnimation")
        return moveAction
    }
    
    func pressButton() -> SKAction {
        return animateNode(textureAtlas: SKTextureAtlas(named: "trumpPressButton"), timePerFrame: 0.1, timeOfAnimation: 0.5)
    }
    
    func drink() -> SKAction {
        if angryMeter > 90 {
            angryMeter = 80
        }
        return animateNode(textureAtlas: SKTextureAtlas(named: "trumpDrink"), timePerFrame: 0.3, timeOfAnimation: 3.0)
    }
    
    func stomp() -> SKAction {
        return animateNode(textureAtlas: SKTextureAtlas(named: "trumpStomp"), timePerFrame: 0.3, timeOfAnimation: 1.5)
    }
    
    func sleep() -> SKAction {
        return animateNode(textureAtlas: SKTextureAtlas(named: "trumpSleep"), timePerFrame: 0.5, timeOfAnimation: 0)
    }
    
    func lazy() -> SKAction {
        return animateNode(textureAtlas: SKTextureAtlas(named: "trumpLazy"), timePerFrame: 1.0, timeOfAnimation: 0)
    }
    
    func shrug() -> SKAction {
        return animateNode(textureAtlas: SKTextureAtlas(named: "trumpShrug"), timePerFrame: 0.3, timeOfAnimation: 0.6)
    }
    
    func yawn() -> SKAction {
        return animateNode(textureAtlas: SKTextureAtlas(named: "trumpYawn"), timePerFrame: 0.5, timeOfAnimation: 1.0)
    }
    
    func touched() -> SKAction {
        changeAngryMeter(value: 10)
        return animateNode(textureAtlas: SKTextureAtlas(named: "trumpTouched"), timePerFrame: 0.3, timeOfAnimation: 0.6)
    }
    
    func smile() -> SKAction {
        return animateNode(textureAtlas: SKTextureAtlas(named: "trumpSmile"), timePerFrame: 1.0, timeOfAnimation: 2.0)
    }
    
    func typeTweet() -> SKAction {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.changeNumTweets(value: 1)
        }
        return animateNode(textureAtlas: SKTextureAtlas(named: "trumpTypeTweet"), timePerFrame: 0.3, timeOfAnimation: 3)
    }
    
    func nuclearState() -> SKAction {
        return animateNode(textureAtlas: SKTextureAtlas(named: "trumpNuclearState"), timePerFrame: 0.3, timeOfAnimation: 0)
    }
    
    func pressNuclearButton() -> SKAction {
        return animateNode(textureAtlas: SKTextureAtlas(named: "trumpPressNuclearButton"), timePerFrame: 0.5, timeOfAnimation: 2.0)
    }
    
    //MARK: - Helper Functons
    
    func removeAction(key: String) -> SKAction {
        let removeAction = SKAction.run({ [weak self] in
            self?.removeAction(forKey: key)
        })
        return removeAction
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
