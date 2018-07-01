//
//  SignUpViewController.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    var token = ""

    @IBAction func signUp(_ sender: UIButton) {
        if let username = usernameText.text,
            let password = passwordText.text,
            let confirmPassword = confirmPasswordText.text {
            if password != confirmPassword {
                errorLabel.text = "password and confirm password does not match"
                clearText()
            } else {
                CreateReaderDataService().createUser(username: username, password1: password, password2: confirmPassword) { response in
                    print("\(response)")
                    if response != "Login failed" {
                        // This works but it won't allow me to add a bar button item
                        // let logTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "LogTableViewController") as! LogTableViewController
                        // self.navigationController?.pushViewController(logTableViewController, animated: true)
                        self.token = response
                        self.performSegue(withIdentifier: "SignupToLogIdentifier", sender: nil)
                        // self.dismiss(animated: false, completion: nil)
                    } else {
                        self.clearText()
                        self.errorLabel.text = "Signup failed"
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

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
