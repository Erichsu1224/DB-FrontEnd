//
//  ViewController.swift
//  Music Plus
//
//  Created by 劉品萱 on 2019/9/19.
//  Copyright © 2019 劉品萱. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class ViewController: UIViewController{
    
    var loadcount = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Sign Up treaty agree buttom
    /*@IBAction func checkboxTuapped(sender:UIButton)
    {
        if(sender.isSelected)
        {
            sender.isSelected = false
        }
        else
        {
            sender.isSelected = true
        }
    }*/
    
    
    // PageViewController
    var CenterPVC:CenterPageViewController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "PVCSegue")
        {
            if(segue.destination.isKind(of: CenterPageViewController.self))
            {
                CenterPVC = segue.destination as? CenterPageViewController
            }
        }
    }
    
    // Change Page By Index Number
    @IBAction func FourPageFirst(_ sender: Any) {
        CenterPVC.setViewControllerFromIndex(index: 0)
    }
    
    @IBAction func FourPageSecond(_ sender: Any) {
        CenterPVC.setViewControllerFromIndex(index: 1)
    }
    
    @IBAction func FourPageThird(_ sender: Any) {
        CenterPVC.setViewControllerFromIndex(index: 2)
    }
    
    @IBAction func FourPageFourth(_ sender: Any) {
        CenterPVC.setViewControllerFromIndex(index: 3)
    }
    
    @IBAction func FourPageFifth(_ sender: Any) {
        CenterPVC.setViewControllerFromIndex(index: 4)
    }
    
}


class CustomButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBUttomStyle()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setBUttomStyle()
    }
    func setBUttomStyle(){
        layer.cornerRadius = 20 // 邊框橢圓
    }
}

func DownloadAudio(with url: URL){
    
}
