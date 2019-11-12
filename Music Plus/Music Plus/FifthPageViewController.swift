//
//  FifthPageViewController.swift
//  Music Plus
//
//  Created by 劉品萱 on 2019/9/21.
//  Copyright © 2019 劉品萱. All rights reserved.
//

import Foundation
import UIKit

class FifthPageViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //播放音樂介面 播放與暫停按鈕切換
    @IBAction func ButtomMusicPlayTapped(sender:UIButton)
    {
        if(sender.isSelected)
        {
            sender.isSelected = false
        }
        else
        {
            sender.isSelected = true
        }
    }
}
