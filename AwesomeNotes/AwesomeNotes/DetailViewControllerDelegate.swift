//
//  DetailViewControllerDelegate.swift
//  AwesomeNotes
//
//  Created by Victor Pimentel Rodriguez on 27/09/14.
//  Copyright (c) 2014 Victor Pimentel Rodriguez. All rights reserved.
//

import Foundation

protocol DetailViewControllerDelegate {
    func detailViewController(detailViewController: DetailViewController, didChangeNote: Note)
}
