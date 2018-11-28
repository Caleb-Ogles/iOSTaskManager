//
//  ViewController.swift
//  iOSTaskManager
//
//  Created by Caleb Ogles on 11/26/18.
//  Copyright © 2018 Caleb Ogles. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class TaskViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let taskLibrary = Library.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskLibrary.tasks.append
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
    }
    
    func incomplete(indexPath: IndexPath) {
        let task = self.taskLibrary.tasks[indexPath.row]
        
        let calendar = Calendar(identifier: .gregorian)
        let dueDate = calendar.date(byAdding: .hour, value: 3, to: Date())!
        
        task.dueDate = .incomplete(dueDate: dueDate)
        (tableView.cellForRow(at: indexPath) as! TaskLibraryCell).setup(task: task)
    }
    
    func complete(indexPath: IndexPath) {
        let task = self.taskLibrary.tasks[indexPath.row]
        task.dueDate = .complete
        (tableView.cellForRow(at: indexPath) as! TaskLibraryCell).setup(task: task)
    }
    
    @IBAction func unwindToLibraryScreen(segue: UIStoryboardSegue){}
    
}


extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskLibrary.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskLibraryCell
        
        let task = taskLibrary.tasks[indexPath.row]
        cell.setup(task: task)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            Library.sharedInstance.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let task = taskLibrary.tasks[indexPath.row]
        
        //Displays the complete and incomplete options to select and depending on which is selected the view changes color to indicate such
        switch task.dueDate {
            
        case .complete:
            
            let completeAction = UITableViewRowAction(style: .normal, title: "Complete") { _, indexPath in
                self.complete(indexPath: indexPath)
            }
            return [deleteAction, completeAction]
            
        case .incomplete:
            
            let incompleteAction = UITableViewRowAction(style: .normal, title: "Incomplete") { _, indexPath in
                self.incomplete(indexPath: indexPath)
            }
            return [deleteAction, incompleteAction]
        }
        
    }
    
}


extension TaskViewController {
    func title(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        let text = "There are no tasks"
        
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25.0), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        let text = "Tap Add task to add a task to your library."
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0), NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.paragraphStyle: paragraph]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView?) -> UIColor? {
        return UIColor.white
    }
}
