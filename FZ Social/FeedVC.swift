//
//  FeedVC.swift
//  FZ Social
//
//  Created by Le Anh Duc on 3/23/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper
class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
    }

    @IBAction func signOutTapped(_ sender: Any) {
        
        let result = KeychainWrapper.standard.removeObject(forKey: KEY_CHAIN)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "logOut", sender: nil)
        
        
    }
}
