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
    let velocityMultiplier: CGFloat = 0.12
    let bgSize = 600
    let heroStartSize = 20
    
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
        hero.physicsBody?.collisionBitMask = CategoryBitmask.screenBounds.rawValue
        hero.name = "player"
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
        createMonsters()
//        drawPlayableArea()
    }
    
    override func didSimulatePhysics() {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        cam.position = player.position
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
    
    private func createMonsters(){
        for _ in 1...19{
            let randRadi = randomNum(lower: 3, upper: 2 * heroStartSize)
            let startPos = createRandomStartPosition(accountingForRadius: randRadi)
            let monster = MonsterVirus.init(radius: CGFloat(randRadi), startPos: startPos, imageNamed: "badVirus")
            addChild(monster)
        }
    }
    
    private func createRandomStartPosition(accountingForRadius radius:Int)->CGPoint{
        let minPoint:Double = Double(randomNum(lower: 50, upper: 200))
        let pointSeed = arc4random_uniform(UInt32(bgSize))
        let pointX = addAbsoluteValue(numToAdd: Int(minPoint), addee: randomNum(lower: -(Int(pointSeed+1)) , upper: Int(pointSeed)))
        let pointY = addAbsoluteValue(numToAdd: Int(minPoint), addee: randomNum(lower: -(Int(pointSeed+1)) , upper: Int(pointSeed)))
        print("seed: \(pointSeed) radius: \(radius), point: \(CGPoint(x: pointX, y: pointY))")
        return CGPoint(x: pointX, y: pointY)
    }
    
    private func randomNum(lower:Int, upper:Int)->Int{
        return Int(arc4random_uniform(UInt32(upper - lower))) + lower
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
