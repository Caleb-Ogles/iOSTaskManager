//
//  TaskLibraryCell.swift
//  iOSTaskManager
//
//  Created by Caleb Ogles on 11/28/18.
//  Copyright © 2018 Caleb Ogles. All rights reserved.
//

import UIKit

class TaskLibraryCell: UITableViewCell {
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskDueDateLabel: UILabel!
    @IBOutlet weak var taskPriorityLabel: UILabel!
    @IBOutlet weak var markerView: UIView!
    
    
    func setup(task: Task) {
        
        taskTitleLabel.text = task.title
        taskPriorityLabel.text = task.priority.rawValue
        
        switch task.dueDate {
            
        case .complete:
            taskDueDateLabel.isHidden = true
            markerView.backgroundColor = .green
            
        case .incomplete(let date):
            taskDueDateLabel.isHidden = false
            markerView.backgroundColor = .red
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            taskDueDateLabel.text = dateFormatter.string(from: date)
        }
        
    }
}

