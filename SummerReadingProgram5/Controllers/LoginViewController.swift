//
//  ViewController.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import UIKit

///
/// Controller to handle login
///
class LoginViewController: UIViewController {
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    let userDefaults = UserDefaults.standard
    var token = ""
    
    @IBAction func login(_ sender: UIButton) {
        if let username = usernameText.text,
            let password = passwordText.text {
            let loginReaderDataService = LoginReaderDataService()
            loginReaderDataService.login(username: username, password: password) { response in
                if response != "Login failed" {
                    self.token = response
                    self.performSegue(withIdentifier: "LogIdentifier", sender: self)
                } else {
                    self.errorLabel.text = "Login failed"
                    self.clearText()
                }
            }
        }
    }
    
    func validate(username: String?, password: String?) -> Bool {
        guard let username = username,
            let password = password,
            username.count >= 1,
            password.count >= 8 else {
                return false
        }
        return true
    }
    
    func enableLoginButton(_ enable: Bool) {
        loginButton.isEnabled = enable
        loginButton.alpha = enable ? 1.0 : 0.5
    }
    
    func clearText() {
        usernameText.text = ""
        passwordText.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LogIdentifier" {
            let uINavigationController = segue.destination as! UINavigationController
            let logTableViewController = uINavigationController.topViewController as! LogTableViewController
            logTableViewController.token = token
        }
    }
}

