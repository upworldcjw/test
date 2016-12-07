//
//  NewGameSence.swift
//  SpriteKitTest
//
//  Created by JianweiChenJianwei on 2016/11/3.
//  Copyright © 2016年 cjw. All rights reserved.
//

import Foundation
import SpriteKit

class NewGameSence: SKScene {
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.orange
//        self.scaleMode = SKSceneScaleMode.fill
        
        
        let splash = SKSpriteNode(color: UIColor.red, size: CGSize.init(width: 50, height: 50))
        splash.position = CGPoint.init(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0)
        self.addChild(splash)
        
        var lilyNormalMap = splash.texture?.generatingNormalMap()
        splash.normalTexture = lilyNormalMap
        splash.lightingBitMask = 1;
        splash.name = "lily test";
        

        
        
//        let splash2 = SKSpriteNode(fileNamed: "Spaceship")
//        self.addChild(splash2!)
        
        let splash3 = SKSpriteNode.init(imageNamed: "Spaceshipsmall")
        splash3.position = CGPoint.init(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0)
//        splash3.anchorPoint = CGPoint.init(x: 0, y: 0)
//        splash3.color = UIColor.green
//        splash3.colorBlendFactor = 0.5
//        splash3.size = CGSize.init(width: 2*100, height: 2*80)
        splash3.setScale(0.3);
//        splash3.zRotation = CGFloat(M_PI)/2;
        splash.lightingBitMask =  1;
        self.addChild(splash3)
//        splash3.removeFromParent()
        
        
        let lightSplash = SKLightNode()
        lightSplash.position = CGPoint.init(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0)
        lightSplash.name = "light"
        lightSplash.categoryBitMask = 1;
        lightSplash.lightColor = UIColor.green
        lightSplash.ambientColor = UIColor.green
        self.addChild(lightSplash)
        
    }
} 
