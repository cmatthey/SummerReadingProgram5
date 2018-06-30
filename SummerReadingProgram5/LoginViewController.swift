//
//  ViewController.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    // https://ux.stackexchange.com/questions/34243/what-is-the-best-register-sign-up-text-for-submit-buttons-on-forms

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func login(_ sender: UIButton) {
        if let username = usernameText.text,
            let password = passwordText.text {
            let loginReaderDataService = LoginReaderDataService()
            loginReaderDataService.login(username: username, password: password)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: check if the goal has been set
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
}

