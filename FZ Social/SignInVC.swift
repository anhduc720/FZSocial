//
//  ViewController.swift
//  FZ Social
//
//  Created by Le Anh Duc on 3/23/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("Unable login with facebook")
            }
            else if result?.isCancelled == true {
                print("User has canceled")
            }
            else {
                print("Successfully login with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                
            }
            
        }
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (result, error) in
            if error != nil {
                print("Unable to authenticate with FireBase")
            } else {
                print("Successfully authenticated with FireBase")
            }
        })
        
    }

}

