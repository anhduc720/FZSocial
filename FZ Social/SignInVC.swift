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
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if KeychainWrapper.standard.string(forKey: KEY_CHAIN) != nil {
            performSegue(withIdentifier: "FeedVC", sender: nil)
        }
        
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
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Unable to authenticate with FireBase")
            } else {
                print("Successfully authenticated with FireBase")
                if let user = user {
                    let userData = ["provider":credential.provider]
                    self.saveUserCredential(userID: user.uid, userData: userData)
                }
            }
        })
        
    }
    
    func saveUserCredential(userID: String, userData: Dictionary<String, String>){
        
        DataService.ds.createFirebaseUserDB(uid: userID, userData: userData)
        
        let result = KeychainWrapper.standard.set(userID, forKey: KEY_CHAIN)
        performSegue(withIdentifier: "FeedVC", sender: nil)
        print("Save User \(result)")
        
    }

    @IBAction func signInTapped(_ sender: Any) {
        
        if let email = emailField.text, let pwd = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                
                if error == nil {
                    
                    print("User authenticated with firebase")
                    
                    if let user = user {
                        let userData = ["provider":user.providerID]
                        self.saveUserCredential(userID: user.uid, userData: userData)
                    }
                    
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        
                        if error != nil {
                            
                            print("Unable to authenticate with firebase using email")
                            
                        } else {
                            
                            print("Successfully authenticated with firebase using email")
                            if let user = user {
                                let userData = ["provider":user.providerID]
                                self.saveUserCredential(userID: user.uid, userData: userData)
                            }
                        }
                        
                        
                    })
                }
                
            })
        }
        
    }
}

