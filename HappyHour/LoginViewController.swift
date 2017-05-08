//
//  LoginViewController.swift
//  HappyHour
//
//  Created by Tyler Gering on 4/23/17.
//  Copyright © 2017 Tyler Gering. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    var userName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create standard FB Login button
        let loginButton = FBSDKLoginButton()
        
        loginButton.frame = CGRect(x: 16, y:100, width: view.frame.width - 32, height: 50)
        loginButton.delegate = self
        view.addSubview(loginButton)
        userName = self.showEmailAddress()
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Successfully logged out of Facebook.")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        userName = showEmailAddress()
    }
    
    func showEmailAddress() -> String{
        
        var data = [String:AnyObject]()
        
        guard let accessToken = FBSDKAccessToken.current() else {
            return ""
        }
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Something went wrong with FB user: ", error ?? "")
            }
            
            print("Succussfully logged in with user", user ?? "")
            
        })
        
        print("Successfully logged in with Facebook...")
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start {
            (connection,result,err) in
            
            if err != nil {
                print("Failed to start Graph Request: ",err ?? "")
                return
            }
            data = result as! [String : AnyObject]
            self.userName = data["name"] as! String
        }
        
        print("Performing Segue")
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
        return ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let nextScene =  segue.destination as! SelectView
            nextScene.userName = userName
    }
    

}


    
    
