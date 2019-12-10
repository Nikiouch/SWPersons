//
//  PersonsListTableViewController.swift
//  SWPersons
//
//  Created by Никита Главацкий on 05.12.2019.
//  Copyright © 2019 StreetPeople. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class PersonsListTableViewController: UITableViewController {

    var json: [[String: Any]]?
    var persons: Results<Person>?
    let uiRealm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        if json == nil{
            persons = uiRealm.objects(Person.self)
            print(persons)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard json != nil else {
            return persons!.count
        }
        return json!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCellIdentifier", for: indexPath) as! PersonCell
        
        if json == nil{
            cell.personNameField.text = persons?[indexPath.row].name
        }else{
            cell.personNameField.text = json?[indexPath.row]["name"] as? String
        }
        

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "OpenPersonDetails", sender: indexPath)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "OpenPersonDetails":
            let indexPath = sender as! IndexPath
            let personDetailsVC: PersonDetailsVC = segue.destination as! PersonDetailsVC
            if json == nil{
                personDetailsVC.person = persons?[indexPath.row]
            }else{
                personDetailsVC.json = json?[indexPath.row]
            }
        case .none:
            print("")
        case .some(_):
            print("")
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
