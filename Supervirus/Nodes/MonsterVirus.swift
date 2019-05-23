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
        physics.allowsRotation = false
        physics.affectedByGravity = false
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
        Timer.scheduledTimer(withTimeInterval: TimeInterval(duration), repeats: true) { timer in
            let scene = self.scene as! GameScene
            let pointInScene = scene.createRandomStartPosition(accountingForStartRadius: Int(self.radius))
            self.run(SKAction.move(to: pointInScene, duration: 5.0))
        }
    }
    
}
