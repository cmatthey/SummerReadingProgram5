//
//  LogTableViewController.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/30/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import UIKit

///
/// Controller to display a table view of reading logs
///
class LogTableViewController: UITableViewController {
    
    var token = ""
    var readerId = -1
    var logs = [Log]()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        readerId = userDefaults.integer(forKey: "readerId")
        let goal = userDefaults.integer(forKey: "goal")
        print("readerId \(readerId) goal \(goal)")
        
        LogDataService().getLogs(readerId: readerId) { logs in
            print("len of logs \(logs!.count)")
            
            DispatchQueue.main.async {
                self.logs = logs!
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("len of self.logs \(self.logs.count)")
        return self.logs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogItem", for: indexPath)
//        readerId = userDefaults.integer(forKey: "readerId")
//        LogDataService().getLogs(readerId: readerId) { logs in
//            if let logs = logs {
//                print("len of logs \(logs.count) indexPath \(indexPath.row)")
//                if logs.count > 0 {
//                    if indexPath.row < logs.count {
//                        let log = logs[indexPath.row]
//                        cell.textLabel!.text = log.title
//                        cell.detailTextLabel!.text = log.author
//                    } else {
//                        cell.textLabel!.text = ""
//                        cell.detailTextLabel!.text = ""
//                    }
//                } else {
//                    // Empty reading logs for new users
//                }
//            }
//        }
        
        if logs.count > 0 {
            if indexPath.row < logs.count {
                let log = logs[indexPath.row]
                cell.textLabel!.text = log.title
                cell.detailTextLabel!.text = log.author
            } else {
                cell.textLabel!.text = ""
                cell.detailTextLabel!.text = ""
            }
        } else {
            // Empty reading logs for new users
        }
        
        return cell
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
