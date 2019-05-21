//
//  Virus.swift
//  FirstGame
//
//  Created by Jimmy Liang on 5/14/19.
//  Copyright © 2019 Jimmy Liang. All rights reserved.
//

import SpriteKit

class Virus : SKSpriteNode
{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    init(radius: CGFloat, startPos: CGPoint, imageNamed: String){
        super.init(texture: SKTexture.init(imageNamed: imageNamed), color: .red, size: CGSize(width: radius * 2, height: radius * 2))
        //        let virusCircle = CGMutablePath()
        //        virusCircle.addArc(center: startPos, radius: radius, startAngle: 0, endAngle: 2 * CGFloat(Double.pi * 2), clockwise: true)
        position = startPos
    }
}


class HeroVirus : Virus
{
    lazy private var virusImage: SKTexture = {
        let virusImage: SKTexture = SKTexture.init(imageNamed: "heroVirus")
        return virusImage
    }()
    
    lazy private var radius: CGFloat = {
        let startSize = virusImage.size()
        return startSize.width/2
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(radius: CGFloat, startPos: CGPoint, imageNamed: String) {
        super.init(radius: radius, startPos: startPos, imageNamed: imageNamed)
        
        let path = CGMutablePath()
        path.addArc(center: CGPoint.zero, radius: radius, startAngle: 0, endAngle: 2 * CGFloat(Double.pi), clockwise: true)
        let physics = SKPhysicsBody(circleOfRadius: radius)
        physics.allowsRotation = false
        physics.affectedByGravity = false
        physicsBody = physics
//        physicsBody?.affectedByGravity = false
//        physicsBody?.angularVelocity = 0
    }
    
    
    
    
}

enum CategoryBitmask: UInt32 {
    case heroVirus = 0
    case enemyVirus = 0b10
    case heroLasers = 0b100
    case screenBounds = 0b1000
}
