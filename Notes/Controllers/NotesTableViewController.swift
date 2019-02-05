//
//  FoldersTableTableViewController.swift
//  Notes
//
//  Created by Artem Karmaz on 1/30/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    
    var notes = Notes()
    var filteredNotes = [Lists]()
    private let searchController = UISearchController(searchResultsController: nil)
    private let cellReuseIdentifier = "cell"
    
    @IBOutlet var foldersTableView: UITableView!
    @IBAction func startNewText(_ sender: UIBarButtonItem) {
        notes.numberOfNote = 100
        teleportToNotesViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    fileprivate func createFoldersTableView() {
        self.foldersTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.foldersTableView.separatorStyle = .none
        self.foldersTableView.delegate = self
        self.foldersTableView.dataSource = self
    }
    
    fileprivate func createSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Notes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    fileprivate func createSearchBarScope() {
        searchController.searchBar.scopeButtonTitles = ["All", "Notes"]
        searchController.searchBar.delegate = self
    }
    
    private func alertNil() {
        let alert = UIAlertController(title: "Something went wrong", message: "The note name can not be empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func alertController() {
        
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSearchBarScope()
        createSearchController()
        setUpToolbar()
        createFoldersTableView()
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredNotes.count
        }
        return self.notes.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.foldersTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let note: Lists
        if isFiltering() {
            note = filteredNotes[indexPath.row]
        } else {
            note = self.notes.list[indexPath.row]
        }
        cell.textLabel?.text = note.name
        cell.detailTextLabel?.text = note.category
        cell.selectionStyle = .gray
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Notes"
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.notes.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func updateCell() {
        let indexPath = NSIndexPath(row: self.notes.list.count, section: 0)
        self.tableView.reloadRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.fade)
    }
    

    func searchBarIsEmpty() -> Bool {
        
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredNotes = notes.list.filter({( name : Lists) -> Bool in
            let doesCategoryMatch = (scope == "All") || (name.category == scope)
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && name.self.name.lowercased().contains(searchText.lowercased())
            }
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
}


extension NotesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension NotesTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
