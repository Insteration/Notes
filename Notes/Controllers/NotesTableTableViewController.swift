//
//  FoldersTableTableViewController.swift
//  Notes
//
//  Created by Artem Karmaz on 1/30/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class NotesTableTableViewController: UITableViewController {
    
    var notes = Notes()
    
    
    private let cellReuseIdentifier = "cell"
    
    
    
    @IBOutlet var foldersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpToolbar()
        self.foldersTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        foldersTableView.separatorStyle = .none
        foldersTableView.delegate = self
        foldersTableView.dataSource = self
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.notes.notesList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.foldersTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = self.notes.notesList[indexPath.row]
        cell.selectionStyle = .gray
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Notes"
    }
    
    func alertController() {
        let alertController = UIAlertController(title: "Add new note", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter note name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let firstSecondField = alertController.textFields![0] as UITextField
            self.notes.notesList.insert(firstSecondField.text!, at: 0)
            let indexPath = NSIndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.fade)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
//        alertController.addTextField { (textField : UITextField!) -> Void in
//            textField.placeholder = "Type tags"
//        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    fileprivate func teleportToNotesViewController() {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let notesViewController = storyboard.instantiateViewController(withIdentifier: "notesVC") as! TextViewController
        notesViewController.notes = notes
        let navigationController = UINavigationController(rootViewController: notesViewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        notes.numberOfNote = indexPath.row
        teleportToNotesViewController()
    }
    
    
    private func setUpToolbar() {
        
        var toolBarItems = [UIBarButtonItem]()
        
        let systemButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        toolBarItems.append(systemButton1)
        
        let systemButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBarItems.append(systemButton2)
        
        let systemButton3 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNewNote(target:)))
        toolBarItems.append(systemButton3)
        
        self.setToolbarItems(toolBarItems, animated: true)
        self.navigationController?.isToolbarHidden = false
    }
    
    @objc func addNewNote(target: UITableViewCell) {
        alertController()
        
        print("Add")
        
        //        foldersTableView.beginUpdates()
        //        foldersTableView.insertRows(at: [IndexPath(row: self.notes.notesList.count-1, section: 1)], with: .automatic)
        //        foldersTableView.endUpdates()
    }
    
    @objc func reloadData(target: UITableViewCell) {
                            self.foldersTableView.beginUpdates()
//                            foldersTableView.insertRows(at: [IndexPath(row: self.notes.notesList.count-1, section: 1)], with: .automatic)
                            self.foldersTableView.endUpdates()
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
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
