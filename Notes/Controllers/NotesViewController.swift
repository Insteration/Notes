//
//  NotesViewController.swift
//  Notes
//
//  Created by Artem Karmaz on 1/30/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    var notes: Notes?
    var notesData = NotesData()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch notes?.numberOfNote {
        case 0:
            self.noteTextView.text = notesData.testNote1
        case 1:
            self.noteTextView.text = notesData.testNote2
        case 2:
            self.noteTextView.text = notesData.testNote3
        default:
            ()
        }

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBAction func showButton(_ sender: UIBarButtonItem) {

    }
    @IBAction func backToNotesListButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
