//
//  HomePage.swift
//  Music Plus
//
//  Created by 劉品萱 on 2019/10/3.
//  Copyright © 2019 劉品萱. All rights reserved.
//

import Foundation
import UIKit
import Charts

class HomePage: UIViewController{
    
    
    @IBOutlet weak var RankButton: UIButton!
    @IBOutlet weak var RecommendButton: UIButton!
    @IBOutlet weak var FindButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RankButton.setTitleColor(UIColor.orange, for: .normal)
        RankButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        
        //GetSongName()
        // Do any additional setup after loading the view.
    }
    
    
    var CenterPVC:HomePVC!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "HomePVCSegue")
        {
            if(segue.destination.isKind(of: HomePVC.self))
            {
                CenterPVC = segue.destination as? HomePVC
            }
        }
    }
    @IBAction func HomePageFirst(_ sender: Any) {
        CenterPVC.setViewControllerFromIndex(index: 0)
        RankButton.setTitleColor(UIColor.orange, for: .normal)
        RankButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        RecommendButton.setTitleColor(UIColor.white, for: .normal)
        RecommendButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        FindButton.setTitleColor(UIColor.white, for: .normal)
        FindButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
    }
    
    @IBAction func HomePageSecond(_ sender: Any) {
        
        CenterPVC.setViewControllerFromIndex(index: 1)
        RankButton.setTitleColor(UIColor.white, for: .normal)
        RankButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        RecommendButton.setTitleColor(UIColor.orange, for: .normal)
        RecommendButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        FindButton.setTitleColor(UIColor.white, for: .normal)
        FindButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        
    }
    
    
    @IBAction func HomePageThird(_ sender: Any) {
        CenterPVC.setViewControllerFromIndex(index: 2)
        RankButton.setTitleColor(UIColor.white, for: .normal)
        RankButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        RecommendButton.setTitleColor(UIColor.white, for: .normal)
        RecommendButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        FindButton.setTitleColor(UIColor.orange, for: .normal)
        FindButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
    }
}

class HomePVCRank: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

class HomePVCRecommend: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

class HomePVCFind: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
