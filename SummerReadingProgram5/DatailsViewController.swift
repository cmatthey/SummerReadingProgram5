//
//  DatailsViewController.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 7/1/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import UIKit

class DatailsViewController: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var noteText: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func save(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        let readerId = userDefaults.integer(forKey: "readerId")
        LogDataService().createLog(readerId: readerId, title: titleText!.text!, author: authorText!.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
