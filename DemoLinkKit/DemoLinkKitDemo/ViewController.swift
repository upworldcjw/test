//
//  ViewController.swift
//  IMChatKitDemo
//
//  Created by 王虎 on 2017/1/10.
//  Copyright © 2017年 hoowang. All rights reserved.
//

import UIKit
import DemoLinkKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testExports()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let chatController = DemoChatViewController()
        self.present(chatController, animated: true) { 
            
        }
    }

}

