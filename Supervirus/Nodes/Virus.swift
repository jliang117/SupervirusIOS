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
    var radius: CGFloat
    var score: Int
    
    required init?(coder aDecoder: NSCoder) {
        radius = 0
        score = 0
        super.init(coder: aDecoder)
    }
    
    
    init(radius: CGFloat, startPos: CGPoint, imageNamed: String){
        self.radius = radius
        self.score = Int(radius)
        super.init(texture: SKTexture.init(imageNamed: imageNamed), color: .red, size: CGSize(width: radius * 2, height: radius * 2))
        position = startPos
    }
    
    func getScore()->Int{
        return score
    }
}

