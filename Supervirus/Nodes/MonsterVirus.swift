//
//  MonsterVirus.swift
//  FirstGame
//
//  Created by Jimmy Liang on 5/21/19.
//  Copyright © 2019 Jimmy Liang. All rights reserved.
//

import SpriteKit

class MonsterVirus : Virus
{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(radius: CGFloat, startPos: CGPoint, imageNamed: String) {
        super.init(radius: radius, startPos: startPos, imageNamed: imageNamed)

        let physics = SKPhysicsBody(circleOfRadius: radius)
        physics.isDynamic = false
        physics.allowsRotation = false
        physics.affectedByGravity = false
        physics.categoryBitMask = CategoryBitmask.enemyVirus.rawValue
        physics.collisionBitMask = CategoryBitmask.heroVirus.rawValue | CategoryBitmask.screenBounds.rawValue | CategoryBitmask.enemyVirus.rawValue
        physicsBody = physics
        
        name = "monster"
    }
    
}
