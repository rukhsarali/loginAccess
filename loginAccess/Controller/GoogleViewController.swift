//
//  GoogleViewController.swift
//  loginAccess
//
//  Created by Rukhsar on 11/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit
import GoogleSignIn
class GoogleViewController: UIViewController {
    
    @IBOutlet weak var googleLogOutOutlet: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    var name : String?
    var email : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        UIUpdate()
        googleLogOutOutlet.layer.cornerRadius = 8
    }
    //MARK: - google logOut button
    @IBAction func googleLogOutButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signOut()
        dismiss(animated: true, completion: nil)
        print("signed out from Google")
    }
    //MARK: - update labels
    func UIUpdate () {
        userName.text = name
        userEmail.text = email
    }
}
