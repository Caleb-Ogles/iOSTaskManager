//
//  TaskClass.swift
//  iOSTaskManager
//
//  Created by Caleb Ogles on 11/27/18.
//  Copyright © 2018 Caleb Ogles. All rights reserved.
//

import Foundation

//This is the class to go by when making a task and adding it to the Task array, contains all that is needed to create a task.
class Task {
    
    var title: String
    var description: String
    var priority: Priority
    var dueDate: DueDate
    
    enum Priority: String {
        case high = "High"
        case medium = "Medium"
        case low = "Low"
        
    }
    
    enum DueDate {
        case complete
        case incomplete(dueDate: Date)
        
    }
    
    init(title: String, description: String, priority: Priority) {
        self.title = title
        self.description = description
        self.priority = priority
        self.dueDate = .complete
    
    }
    
}
