//
//  DatailsViewController.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 7/1/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import UIKit
import BarcodeScanner

///
/// Controller to add an entry of reading log
///
class DatailsViewController: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var noteText: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func save(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        let readerId = userDefaults.integer(forKey: "readerId")
        LogDataService().createLog(readerId: readerId, title: titleText!.text!, author: authorText!.text!)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func scan(_ sender: Any) {
        let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        return viewController
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


extension DatailsViewController: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("Barcode Data: \(code)")
        print("Symbology Type: \(type)")
        SearchBooksDataService().searchByISBN(isbn: code) { (title, author) in
            DispatchQueue.main.async {
                self.titleText.text = title
                self.authorText.text = author
            }
        }
        navigationController?.popViewController(animated: true)
//        controller.dismiss(animated: true, completion: nil)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            controller.resetWithError()
//        }
    }
}

extension DatailsViewController: BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
}

extension DatailsViewController: BarcodeScannerDismissalDelegate {
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
