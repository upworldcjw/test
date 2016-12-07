//
//  GameViewController.swift
//  SpriteKitTest
//
//  Created by JianweiChenJianwei on 2016/11/3.
//  Copyright © 2016年 cjw. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    let test = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if test == 1 {
                // Load the SKScene from 'GameScene.sks'
                if let scene = SKScene(fileNamed: "GameScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene)
                }
            }else if test == 2{
                let scene = GameScene(size:CGSize.init(width: 100, height: 100))
                
                scene.scaleMode = .aspectFill
                
                view.presentScene(scene)
            }else if test == 3{
                if view.scene == nil {
                    let scene = NewGameSence(size:CGSize.init(width: 100, height: 100))
                    
                    view.presentScene(scene)
                }
            }
            

            view.showsDrawCount = true
            view.ignoresSiblingOrder = true
            view.showsFields = true;
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsQuadCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
