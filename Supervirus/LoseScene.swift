//
//  LoseScene.swift
//  Supervirus
//
//  Created by Jimmy Liang on 5/22/19.
//  Copyright © 2019 Jimmy Liang. All rights reserved.
//

import SpriteKit

class LoseScene: SKScene{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(size: CGSize, score: Int) {
        super.init(size: size)
        
        backgroundColor = .white
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "you fakn looz"
        label.fontSize = 40
        label.fontColor = .red
        label.position = CGPoint(x: 0, y: 40)
        addChild(label)
        
        let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "your score was \(score)...tap to reload"
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = .red
        scoreLabel.position = CGPoint(x: 0, y: -40)
        addChild(scoreLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        run(SKAction.sequence([
            SKAction.run {
                let reveal = SKTransition.crossFade(withDuration: 0.5)
                let scene = GameScene(size: self.size)
                self.view?.presentScene(scene, transition:reveal)
            }
            ]))
    }
    
}
