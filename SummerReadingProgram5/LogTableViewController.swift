//
//  LogTableViewController.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/30/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import UIKit

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
        // #warning Incomplete implementation, return the number of rows
        LogDataService().getLogs(readerId: readerId) { logs in
            print("len of logs \(logs!.count)")
            self.logs = logs!
        }
        print("len of self.logs \(self.logs.count)")
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogItem", for: indexPath)
        // TODO: When is method is called during the View state
        readerId = userDefaults.integer(forKey: "readerId")
        LogDataService().getLogs(readerId: readerId) { logs in
            if let logs = logs {
                print("len of logs \(logs.count) indexPath \(indexPath.row)")
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
            }
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
