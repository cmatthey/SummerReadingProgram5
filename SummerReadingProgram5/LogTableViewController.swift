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
        
        LogDataService().getLogs(readerId: readerId) { logs in
            if let logs = logs {
                self.logs = logs
                for log in logs {
                    print("title \(log.title)")
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        do {
            let fm = FileManager.default
            let url = try fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let path = url.appendingPathComponent("reader")
            print("path: \(path.absoluteString).")
            if let reader = NSKeyedUnarchiver.unarchiveObject(withFile: path.absoluteString) as? Reader {
                print("reader in logTableViewController: \(reader).")
            } else {
                print("NSKeyedUnarchiver failure viewDidAppear")
            }
        } catch {
            print("DocumentDirectory error: \(error).")
        }
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
        return logs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogItem", for: indexPath)
        let log = logs[indexPath.row]
        cell.textLabel?.text = log.title
        cell.detailTextLabel?.text = log.author
        
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
