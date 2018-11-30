//
//  AddTaskViewController.swift
//  iOSTaskManager
//
//  Created by Caleb Ogles on 11/27/18.
//  Copyright © 2018 Caleb Ogles. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    let taskLibrary = Library.sharedInstance
    
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var dueDateDatePicker: UIDatePicker!
    
    @IBAction func saveTapped(_ sender: Any) {
        trySavingTask()
        performSegue(withIdentifier: "unwindToLibraryScreen", sender: self)
    }
    
    let segments: [(title: String, priority: Task.Priority)] =
        [("High", .high),
         ("Medium", .medium),
         ("Low", .low)]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prioritySegmentedControl.removeAllSegments()
        
        for (index, segment) in segments.enumerated() {
            prioritySegmentedControl.insertSegment(withTitle: segment.title, at: index, animated: false)
        }
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    //function for taking the input the user makes and when called bundles the values into an array together
    func trySavingTask() {
        
        guard let title = taskTitleTextField.text else { return }
        
        guard let description = descriptionTextView.text else { return }
        
        let priority = segments[prioritySegmentedControl.selectedSegmentIndex].priority
        
        taskLibrary.tasks.append(Task(title: title, description: description, priority: priority))
        
        
    }
    
}
