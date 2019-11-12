//
//  LoginViewController.swift
//  Music Plus
//
//  Created by 劉品萱 on 2019/10/3.
//  Copyright © 2019 劉品萱. All rights reserved.
//

import Foundation
import UIKit
//import CommonCrypto



// Login Request By POST with User Information
class LoginViewController: UIViewController{
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var LoginButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //LoginButton.isEnabled = false
    }
    
    @IBAction func EmailTextFieldEditChange(_ sender: UITextField) {
        print(sender.text!)
    }
    
    
    @IBAction func LoginWithPost(_ sender: Any) {
        
        let EmailWithSHA256 = EmailTextField.text
        let PasswordWithSHA256 = PasswordTextField.text?.sha256String ?? ""
        
        let parameters:[String:Any] = ["Email": EmailWithSHA256, "Password": PasswordWithSHA256] as! [String:Any]
        
        
        guard let url = URL(string: "http://140.136.149.239:3000/user/login") else {return}
        
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
        
/*let EmailWithSHA256 = EmailTextField.text
 let PasswordWithSHA256 = PasswordTextField.text?.sha256String ?? ""
 
 let parameters:[String:Any] = ["Email": EmailWithSHA256, "Password": PasswordWithSHA256] as! [String:Any]
 
 
 guard let url = URL(string: "http://140.136.149.239:3000/user/login") else {return}
 
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
 }.resume()*/
        
        
    }
}

