//
//  GameViewController.swift
//  FirstGame
//
//  Created by Jimmy Liang on 5/14/19.
//  Copyright © 2019 Jimmy Liang. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    static let gameSceneViewFactor = CGFloat(1)
    
    lazy var skView: SKView = {
        let view = SKView()
        
        view.isMultipleTouchEnabled = true
        view.frame = CGRect(x: 0.0, y: 0.0, width: ScreenSize.width , height: ScreenSize.height  )
//        view.center = CGPoint.zero
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func setupView(){
        view.addSubview(skView)
    
        let scene = setupScene()
        
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
    }
    
    fileprivate func setupScene() -> SKScene{
        let scene = GameScene(size: CGSize(width: ScreenSize.width * GameViewController.gameSceneViewFactor, height: ScreenSize.height * GameViewController.gameSceneViewFactor))
        scene.scaleMode = .aspectFit
        return scene
    }
    
}
