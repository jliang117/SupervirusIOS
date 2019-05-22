//
//  GameScene.swift
//  FirstGame
//
//  Created by Jimmy Liang on 5/14/19.
//  Copyright © 2019 Jimmy Liang. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    let cam = SKCameraNode()
    
    var scoreLabel = SKLabelNode()
    var positionLabel = SKLabelNode()
    
    let velocityMultiplier: CGFloat = 0.12
    let bgSize: Int = 600
    let heroStartSize: Int = 20
    
    enum NodesZPosition: CGFloat {
        case background, hero, joystick
    }
    
    lazy var playableRect : CGRect = {
        var rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return rect
    }()
    
    lazy var background: SKShapeNode = {
        let path = CGMutablePath()
        path.addArc(center: CGPoint.zero, radius: CGFloat(bgSize), startAngle: 0, endAngle: 2 * CGFloat(Double.pi), clockwise: true)
        
        let sprite = SKShapeNode(path: path, centered: true)
        sprite.strokeColor = .black
        sprite.lineWidth = 6
        sprite.fillColor = .clear
        
        let bgPhys = SKPhysicsBody(edgeLoopFrom: path)
        bgPhys.restitution = 0
        bgPhys.isResting = true
        bgPhys.friction = 0
        bgPhys.affectedByGravity = false
        
        sprite.physicsBody = bgPhys
        sprite.physicsBody?.categoryBitMask =  CategoryBitmask.screenBounds.rawValue
        return sprite
    }()
    
    lazy var player: HeroVirus = {
        var hero = HeroVirus.init(radius: CGFloat(heroStartSize), startPos: CGPoint.zero, imageNamed: "heroVirus")
        return hero
    }()
    
    lazy var analogJoystick: AnalogJoystick = {
        let js = AnalogJoystick(diameter: 100, colors: nil, images: (substrate: UIImage(named: "jSubstrate"), stick: UIImage(named: "jStick")))
        js.position = CGPoint(x: -self.frame.midX, y: -self.frame.midY - 350)
        js.zPosition = NodesZPosition.joystick.rawValue
        return js
    }()

    
    //Mark: Main init
    
    override func didMove(to view: SKView) {
        setupNodes()
        setupCamera()
        setupJoystick()
        createMonsters(numCreated:10)
        createLabels()
//        drawPlayableArea()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        cam.position = player.position
        updatePositionLabel()
        updateScoreLabel()
    }
    
    private func drawPlayableArea(){
        let path = CGMutablePath()
        path.addRect(playableRect)
        let area = SKShapeNode(path: path, centered: true)
        area.lineWidth = 2
        area.strokeColor = .red
        area.position = CGPoint.zero
        
//        addChild(area)
        
    }
    
    private func setupCamera(){
        camera = cam
        addChild(cam)
        cam.addChild(analogJoystick)
        cam.addChild(positionLabel)
        cam.addChild(scoreLabel)
    }
    
    private func createLabels(){
        positionLabel.position = CGPoint(x: frame.midX, y: frame.midY + 200)
        positionLabel.fontColor = .red
        positionLabel.fontName = "Chalkduster"
        positionLabel.fontSize = 32
        
        scoreLabel.position = CGPoint(x: -(frame.size.width * 0.30), y: -(frame.size.height * 0.40))
        scoreLabel.fontColor = .black
        scoreLabel.fontName = "Chalkduster"
        scoreLabel.fontSize = 20
    }
    
    private func updatePositionLabel(){
        let posX: Int = Int(player.position.x)
        let posY: Int = Int(player.position.y)
        positionLabel.text = "x \(posX), y \(posY)"
    }
    
    private func updateScoreLabel(){
        scoreLabel.text = "Score \(player.getScore() - 20)"
    }
    
    private func setupNodes(){
        backgroundColor = SKColor.white
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(background)
        addChild(player)
    }
    
    private func setupJoystick(){
        analogJoystick.trackingHandler = { [unowned self] data in
            self.player.position = CGPoint(x: self.player.position.x + (data.velocity.x * self.velocityMultiplier),
                                         y: self.player.position.y + (data.velocity.y * self.velocityMultiplier))
        }
    }
    
    private func createMonsters(numCreated:Int){
        for _ in 1...numCreated{
            let randRadi = randomBetween(lower: 5, upper: Double(2 * player.radius))
            let startPos = createRandomStartPosition(withRadius: randRadi)
            let monster = MonsterVirus.init(radius: CGFloat(randRadi), startPos: startPos, imageNamed: "badVirus")
            addChild(monster)
        }
    }
    
    private func createRandomStartPosition(withRadius radius:Int)->CGPoint{
        let pointSeed = arc4random_uniform(UInt32(bgSize-radius-100))
        
        let minPoint:Int = randomBetween(lower: 30, upper: 300)
        let minDistanceThreshold: Int = 100
        
        var pointX: Int = randomBetween(lower: -(Double(pointSeed+1)) , upper: Double(pointSeed))
        var pointY: Int = randomBetween(lower: -(Double(pointSeed+1)) , upper: Double(pointSeed))
        
        if pointX < minDistanceThreshold {
            pointX = addAbsoluteValue(numToAdd: minPoint, addee: pointX)
        }
        if pointY < minDistanceThreshold{
            pointY = addAbsoluteValue(numToAdd: minPoint, addee: pointY)
        }
        
//        print("seed: \(pointSeed) radius: \(radius), point: \(CGPoint(x: pointX, y: pointY))")
        return CGPoint(x: pointX, y: pointY)
    }
    
    private func randomBetween(lower:Double, upper:Double)->Int{
        return Int(Double.random(in: lower...upper))
//        return Int(arc4random_uniform(UInt32(upper - lower))) + lower
    }
    
    private func addAbsoluteValue(numToAdd:Int, addee:Int) -> Int{
//        print("adding \(numToAdd) to \(addee)")
        if addee < 0 {
            let retVal = addee - numToAdd
//            print("negative addee, reval is: \(retVal)")
            return retVal
        }
        return numToAdd + addee
    }
}
