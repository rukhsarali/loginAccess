//
//  ViewController.swift
//  loginAccess
//
//  Created by Rukhsar on 09/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
     // Do any additional setup after loading the view.
    }
    @IBAction func facebookLoginButton(_ sender: UIButton) {
        performLogin()
    }
    override func viewDidAppear(_ animated: Bool) {
        if AccessToken.current != nil{
            print("AccessToken.current")
            performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
}
//MARK: - facebook login method
extension ViewController {
    func performLogin() {
        if AccessToken.current != nil{
            print("AccessToken.current")
             performSegue(withIdentifier: "goToResult", sender: self)
        }else {
            let manager = LoginManager()
            manager.logIn(permissions: [Permission.publicProfile], viewController: self) { (loginResult) in
                switch loginResult {
                case .failed(let error):
                    print(error)
                case .cancelled:
                    print("User cancelled login")
                    break
                case .success(granted: _, declined: _, token: _):
                    print("Logged in!")
                  //  self.performSegue(withIdentifier: "goToResult", sender: self)
                    let pvc = self.storyboard?.instantiateViewController(identifier: "goToResult") as? ResultViewController
                    self.present(pvc!, animated: false, completion: nil)
                }
            }
        }
    }
}




//            let pvc = storyboard?.instantiateViewController(identifier: "goToResult") as? ResultViewController
//            present(pvc!, animated: true, completion: nil)
