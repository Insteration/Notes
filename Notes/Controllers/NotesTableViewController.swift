//
//  FoldersTableTableViewController.swift
//  Notes
//
//  Created by Artem Karmaz on 1/30/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    //    var note = [Notes]()
    
    
    var notes = Notes()
    var filteredNotes = [Notes]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private let cellReuseIdentifier = "cell"
    
    
    @IBOutlet var foldersTableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Notes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
        
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
            if isFiltering() {
                return filteredNotes.count
            }
            
//            return self.notes.notesList.count
        return self.notes.list.count
        }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.foldersTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
//        let myNote: Lists
        
//        if isFiltering() {
//            myNote = filteredNotes[indexPath.row]
//        } else {
//            myNote = self.notes.list[indexPath.row]
//        }
//        cell.textLabel?.text = self.notes.notesList[indexPath.row]
        cell.textLabel?.text = self.notes.list[indexPath.row].name
        cell.selectionStyle = .gray
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Notes"
    }
    
    func alertNil() {
        let alert = UIAlertController(title: "Something went wrong", message: "The note name can not be empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func alertController() {
        
        
        let alertController = UIAlertController(title: "Add new note", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter note name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in

            let noteName = alertController.textFields![0] as UITextField

            if noteName.text == "" {
                self.alertNil()
            } else {
                self.notes.list.insert(Lists(name: noteName.text!), at: 0)

//                self.notes.notesList.insert(noteName.text!, at: 0)
                let indexPath = NSIndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.fade)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action : UIAlertAction!) -> Void in })
        
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
        
    }
    
    @objc func reloadData(target: UITableViewCell) {
        self.foldersTableView.beginUpdates()
        //                            foldersTableView.insertRows(at: [IndexPath(row: self.notes.notesList.count-1, section: 1)], with: .automatic)
        self.foldersTableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        print("can edit Row At")
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.notesList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func updateCell() {
        let indexPath = NSIndexPath(row: notes.notesList.count, section: 0)
        
        self.tableView.reloadRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.fade)
        //        tableView.beginUpdates()
        //        tableView.reloadRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.fade) //try other animations
        //        tableView.endUpdates()
    }
    
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if (editingStyle == .delete) {
    //            // handle delete (by removing the data from your array and updating the tableview)
    //        }
    //    }
    
    
    @IBAction func startNewText(_ sender: UIBarButtonItem) {
        notes.numberOfNote = 100
        teleportToNotesViewController()
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
    
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredNotes = [notes].filter({( note : Notes) -> Bool in
            return note.filteredList.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
}


extension NotesTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
