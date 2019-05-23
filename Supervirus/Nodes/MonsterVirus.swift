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
        physics.collisionBitMask = CategoryBitmask.heroVirus.rawValue | CategoryBitmask.screenBounds.rawValue | CategoryBitmask.enemyVirus.rawValue
        physicsBody = physics
        
        name = "monster"
        startMoving()
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func startMoving(){
        let duration = self.random(min: 0, max: 20.0)
        let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(duration), repeats: true) { timer in
            let randX = self.random(min: -CGFloat(600), max: CGFloat(600))
            let randY = self.random(min: -CGFloat(600), max: CGFloat(600))
            self.run(SKAction.move(to: CGPoint(x:randX, y:randY), duration: 5.0))
        }
    }
    
}
