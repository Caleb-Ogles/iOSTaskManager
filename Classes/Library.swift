//
//  Library.swift
//  iOSTaskManager
//
//  Created by Caleb Ogles on 11/28/18.
//  Copyright © 2018 Caleb Ogles. All rights reserved.
//

import Foundation

class Library {
    
    static let sharedInstance = Library()
    //add empty array after task class is created
    var tasks = [Task]()
}
