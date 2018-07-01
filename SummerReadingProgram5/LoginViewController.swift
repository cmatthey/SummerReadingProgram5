//
//  ViewController.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func login(_ sender: UIButton) {
        if let username = usernameText.text,
            let password = passwordText.text {
            let loginReaderDataService = LoginReaderDataService()
            loginReaderDataService.login(username: username, password: password) { response in
                print("\(response)")
                if response != "Login failed" {
                    // This works but it won't allow me to add a bar button item
                    // let logTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "LogTableViewController") as! LogTableViewController
                    // self.navigationController?.pushViewController(logTableViewController, animated: true)
                    self.token = response
                    self.performSegue(withIdentifier: "LogIdentifier", sender: nil)
                    // self.dismiss(animated: false, completion: nil)
                } else {
                    self.clearText()
                    self.errorLabel.text = "Login failed"
                }
            }
        }
    }
    
    let userDefaults = UserDefaults.standard
    var token = ""
    
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
    
    func clearText() {
        usernameText.text = ""
        passwordText.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "LogIdentifier" {
            if let logTableViewController = segue.destination as? LogTableViewController {
                logTableViewController.token = token
            }
        }
    }
}

