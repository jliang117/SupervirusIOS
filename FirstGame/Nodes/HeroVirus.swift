//
//  HeroVirus.swift
//  FirstGame
//
//  Created by Jimmy Liang on 5/21/19.
//  Copyright © 2019 Jimmy Liang. All rights reserved.
//

import SpriteKit


class HeroVirus : Virus
{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(radius: CGFloat, startPos: CGPoint, imageNamed: String) {
        super.init(radius: radius, startPos: startPos, imageNamed: imageNamed)
        
        let path = CGMutablePath()
        path.addArc(center: CGPoint.zero, radius: radius, startAngle: 0, endAngle: 2 * CGFloat(Double.pi), clockwise: true)
        let physics = SKPhysicsBody(circleOfRadius: radius)
        physics.usesPreciseCollisionDetection = true
        physics.collisionBitMask = CategoryBitmask.screenBounds.rawValue | CategoryBitmask.enemyVirus.rawValue
        physics.contactTestBitMask = CategoryBitmask.enemyVirus.rawValue
        physics.allowsRotation = false
        physics.affectedByGravity = false
        physicsBody = physics
        
        name = "player"
    }
    
}
