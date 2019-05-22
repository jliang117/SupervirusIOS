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
        physics.isDynamic = false
        physics.allowsRotation = false
        physics.affectedByGravity = false
        physics.categoryBitMask = CategoryBitmask.enemyVirus.rawValue
        physics.collisionBitMask = CategoryBitmask.heroVirus.rawValue | CategoryBitmask.screenBounds.rawValue | CategoryBitmask.enemyVirus.rawValue
        physicsBody = physics
        
        name = "monster"
    }
    
}
