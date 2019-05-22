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
    
    init(radius: CGFloat, startPos: CGPoint, imageNamed: String, score: Int) {
        super.init(radius: radius, startPos: startPos, imageNamed: imageNamed)
        self.score = score
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
