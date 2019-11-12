//
//  RegisterViewController.swift
//  Music Plus
//
//  Created by 劉品萱 on 2019/10/25.
//  Copyright © 2019 劉品萱. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController:UIViewController{
    
    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBAction func AgreeCheckBox(_ sender: UIButton) {
        if(sender.isSelected)
        {
            sender.isSelected = false
        }
        else
        {
            sender.isSelected = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUpWithPOST(_ sender: Any) {
        
        let Email = EmailTextField.text!
        let Password = PasswordTextField.text?.sha256String ?? ""
        let Nickname = UserNameTextField.text!
        
        let parameters:[String:Any] = ["Email": Email, "Password": Password, "Nickname": Nickname] as! [String:Any]
        
        guard let url = URL(string: "http://140.136.149.239:3000/user/register") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with:  request){
            (data, response, error) in
            if let response = response{
                print(response)
            }
            
            if let data = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }
                catch{
                    print(error)
                }
            }
        }.resume()
    }
}


