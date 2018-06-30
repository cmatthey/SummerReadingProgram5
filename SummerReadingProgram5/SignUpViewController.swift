//
//  SignUpViewController.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func signUp(_ sender: UIButton) {
        if let email = emailText.text,
            let password = passwordText.text,
            let confirmPassword = confirmPasswordText.text {
            if !isValidEmailAddress(email) || password != confirmPassword {
                clear()
            } else {
                let createReaderDataService = CreateReaderDataService()
                    // Variable used within its own initial valueCannot convert value of type '() -> ()' to expected argument type 'String'
//                    print("Email: \(reader.email)")
            }
        }
    }
    
    func isValidEmailAddress(_ emailAddress: String) -> Bool {
        // TODO: implment regex logic http://swiftdeveloperblog.com/email-address-validation-in-swift/
        return true
    }
    
    func clear() {
        emailText.text = ""
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
