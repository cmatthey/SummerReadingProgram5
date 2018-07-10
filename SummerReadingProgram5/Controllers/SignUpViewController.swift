//
//  SignUpViewController.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import UIKit

///
/// Controller to handle sign-up
///
class SignUpViewController: UIViewController {
    // TODO: clear errorLabel
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    let userDefaults = UserDefaults.standard
    var token = ""
    var readerId = -1

    @IBAction func signUp(_ sender: UIButton) {
        if let username = usernameText.text,
            let password = passwordText.text,
            let confirmPassword = confirmPasswordText.text {
            if password != confirmPassword {
                errorLabel.text = "password and confirm password does not match"
                clearText()
            } else {
                CreateReaderDataService().registration(username: username, password1: password, password2: confirmPassword) { token, readerId in
                    if token != "Login failed" {
                        self.token = token
                        self.readerId = readerId
                        self.performSegue(withIdentifier: "SignupToLogIdentifier", sender: self)
                    } else {
                        self.errorLabel.text = "Signup failed"
                        self.clearText()
                    }
                }
                
            }
        }
    }
    
    func clearText() {
        usernameText.text = ""
        passwordText.text = ""
        confirmPasswordText.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readerId = userDefaults.integer(forKey: "readerId")
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignupToLogIdentifier" {
            let uINavigationController = segue.destination as! UINavigationController
            let logTableViewController = uINavigationController.topViewController as! LogTableViewController
            logTableViewController.token = token
            logTableViewController.readerId = readerId
        }
    }

}
