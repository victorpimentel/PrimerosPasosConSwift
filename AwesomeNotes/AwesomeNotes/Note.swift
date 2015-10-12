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
    var body: String = "" {
        didSet {
            updatedAt = NSDate()
        }
    }
    var photo: UIImage? {
        didSet {
            updatedAt = NSDate()
        }
    }
    var createdAt: NSDate
    var updatedAt: NSDate

    init() {
        createdAt = NSDate()
        updatedAt = createdAt
    }
}
