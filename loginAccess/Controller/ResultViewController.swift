//
//  ResultViewController.swift
//  loginAccess
//
//  Created by Rukhsar on 09/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
class ResultViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataGet()
    }
    @IBAction func facebookLogOutButton(_ sender: UIButton) {
        dissmissMethod()
    }
}
//MARK: - get data from loggedIn ID and dissmiss method
extension ResultViewController {
    func dissmissMethod(){
        if AccessToken.current != nil{
            AccessToken.current = nil
            dismiss(animated: true, completion: nil)
        }
    }
    func dataGet () {
        if let token = AccessToken.current,!token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields" : "email , name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start(completionHandler: {connection , result , error in
                // print("uuuuuuuuuuuuuuuu\(result)")
                let resultDic = result as! NSDictionary
                
                let userName = resultDic.value(forKey: "name")
                self.nameLabel.text = userName as! String?
                
                let email = resultDic.value(forKey: "email")
                self.emailLabel.text = email as! String?
            })
        }
    }
}
