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
    var radius:CGFloat
    
    required init?(coder aDecoder: NSCoder) {
        radius = 0
        super.init(coder: aDecoder)
    }
    
    
    init(radius: CGFloat, startPos: CGPoint, imageNamed: String){
        self.radius = radius
        super.init(texture: SKTexture.init(imageNamed: imageNamed), color: .red, size: CGSize(width: radius * 2, height: radius * 2))
        //        let virusCircle = CGMutablePath()
        //        virusCircle.addArc(center: startPos, radius: radius, startAngle: 0, endAngle: 2 * CGFloat(Double.pi * 2), clockwise: true)
        position = startPos
    }
    
    func getScore()->Int{
        return Int(radius)
    }
}

