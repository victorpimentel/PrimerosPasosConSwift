//
//  Note.swift
//  AwesomeNotes
//
//  Created by Victor Pimentel Rodriguez on 27/09/14.
//  Copyright (c) 2014 Victor Pimentel Rodriguez. All rights reserved.
//

import Foundation
import UIKit

class Note {
    var body: NSString = "" {
        didSet {
            updatedAt = NSDate.date()
        }
    }
    var photo: UIImage? {
        didSet {
            updatedAt = NSDate.date()
        }
    }
    var createdAt: NSDate
    var updatedAt: NSDate

    init() {
        createdAt = NSDate.date()
        updatedAt = createdAt
    }
}
