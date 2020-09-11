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
import GoogleSignIn
class ViewController: UIViewController {
    @IBOutlet weak var loginGooglebuttonOutlet: UIButton!
    @IBOutlet weak var loginFacebookbuttonOutlet: UIButton!
    var userGoogleName = ""
    var userGoogleEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateGoogleMethod()
        loginGooglebuttonOutlet.layer.cornerRadius = 8
        loginFacebookbuttonOutlet.layer.cornerRadius = 8
    }
    //MARK: - view did appear after reopen app
    override func viewDidAppear(_ animated: Bool) {
        if AccessToken.current != nil{
            print("AccessToken.current")
            performSegue(withIdentifier: "goToFacebook", sender: self)
        }else if GIDSignIn.sharedInstance()?.currentUser != nil {
            print("already signedin Google")
            performSegue(withIdentifier: "goToGoogle", sender: self)
        }else{
            print("error in vieDidAppear")
        }
    }
    //MARK: - facebook signIn button
    @IBAction func facebookLoginButton(_ sender: UIButton) {
        performFacebookLogin()
    }
    //MARK: - Google signIn button
    @IBAction func googleLoginButton(_ sender: UIButton) {
        performGoogleLogin()
        print("google pressed")
    }
}

//MARK: - facebook login method
extension ViewController {
    func performFacebookLogin() {
        if AccessToken.current != nil{
            print("AccessToken.current")
            performSegue(withIdentifier: "goToFacebook", sender: self)
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
                    let pvc = self.storyboard?.instantiateViewController(identifier: "goToFacebook") as? FacebookViewController
                    self.present(pvc!, animated: true, completion: nil)
                }
            }
        }
    }
}

//MARK: - Google login method
extension ViewController : GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("error \(error.localizedDescription)")
        }else{
            userGoogleName = user.profile.name
            userGoogleEmail = user.profile.email
            performSegue(withIdentifier: "goToGoogle", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGoogle" {
            let destinationVC = segue.destination as! GoogleViewController
            destinationVC.name = userGoogleName
            destinationVC.email = userGoogleEmail
        }else {
            print("you click on facebook login button")
        }
    }
    func performGoogleLogin(){
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            performSegue(withIdentifier: "goToGoogle", sender: self)
            print("Already SignedIn")
        }else {
            GIDSignIn.sharedInstance()?.signIn()
            print("if not signedIn , make new")
        }
    }
    func delegateGoogleMethod () {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
}


