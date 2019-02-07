//
//  NotesViewController.swift
//  Notes
//
//  Created by Artem Karmaz on 1/30/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
//    var note = Notes()
    var notesData = NotesData()
    var timeView: TimeIndicatorView!
    
    var note: Note!


//    @IBOutlet weak var textView: UITextView!
    
    var textView: UITextView!
    var textStorage: SyntaxHighlightTextStorage!
    
    func createTextView() {
        // 1
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        let attrString = NSAttributedString(string: note.contents, attributes: attrs)
        textStorage = SyntaxHighlightTextStorage()
        textStorage.append(attrString)
        
        let newTextViewRect = view.bounds
        
        // 2
        let layoutManager = NSLayoutManager()
        
        // 3
        let containerSize = CGSize(width: newTextViewRect.width,
                                   height: .greatestFiniteMagnitude)
        let container = NSTextContainer(size: containerSize)
        container.widthTracksTextView = true
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)
        
        // 4
        textView = UITextView(frame: newTextViewRect, textContainer: container)
        textView.delegate = self
        view.addSubview(textView)
        
        // 5
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    override func viewDidLayoutSubviews() {
        textStorage.update()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createTextView()
//        timeView = TimeIndicatorView(date: note.timestamp)
//        textView.addSubview(timeView)
        
//        self.textView.font = .preferredFont(forTextStyle: .body)
//        self.textView.adjustsFontForContentSizeCategory = true
        
        let frameTextView = CGRect(x: 0, y: 0, width: self.view.bounds.width - 40, height: self.view.bounds.height / 2)
        self.textView.frame = frameTextView
        
        

        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(param:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(param:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        setUpToolbar()
        
        
//        switch note.numberOfNote {
//        case 0:
//            self.noteTextView.text = notesData.testNote1
//        case 1:
//            self.noteTextView.text = notesData.testNote2
//        case 2:
//            self.noteTextView.text = notesData.testNote3
//        case 100:
////            self.notes.notesList.insert(noteName.text!, at: 0)
//            self.note.list.insert(List(name: "New note"), at: 0)
//
//            self.noteTextView.text = ""
//        default:
//            ()
//        }
        
        
    }
    
    
    @IBAction func showButton(_ sender: UIBarButtonItem) {

    }
//    @IBAction func backToNotesListButton(_ sender: UIBarButtonItem) {
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let notesViewController = storyboard.instantiateViewController(withIdentifier: "mainVC") as! NotesTableViewController
//        notesViewController.notes = notes
////        let navigationController = UITableViewController(rootViewController: notesViewController)
//        self.present(notesViewController, animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.resignFirstResponder()
    }
    
    
    
    private func setUpToolbar() {
        
        var toolBarItems = [UIBarButtonItem]()
        
        let systemButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.bookmarks, target: nil, action: nil)
        toolBarItems.append(systemButton1)
        
        let systemButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBarItems.append(systemButton2)
        
        let systemButton3 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: nil, action: nil)
        toolBarItems.append(systemButton3)
        
        self.setToolbarItems(toolBarItems, animated: true)
        self.navigationController?.isToolbarHidden = false
    }
    
    @objc func updateTextView(param: Notification) {
        let userInfo = param.userInfo
        let getKeyboardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue    // координаты клавиатуры
        let keyBoardFrame = self.view.convert(getKeyboardRect, to: view.window) // конвертирует в координаты на вьюшке (сделали фрейм исходя из координаты клавиатуры)
        if param.name == UIResponder.keyboardWillHideNotification {
            self.textView.contentInset = UIEdgeInsets.zero // по углам
        } else {
            self.textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardFrame.height, right: 0)
            self.textView.scrollIndicatorInsets = self.textView.contentInset
        }
        self.textView.scrollRangeToVisible(self.textView.selectedRange)
    }
    

}

extension TextViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        note.contents = textView.text
//        print(note.name)
    }
}
