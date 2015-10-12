//
//  DetailViewController.swift
//  AwesomeNotes
//
//  Created by Victor Pimentel Rodriguez on 27/09/14.
//  Copyright (c) 2014 Victor Pimentel Rodriguez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var delegate: DetailViewControllerDelegate?

    @IBOutlet weak var detailDescriptionTextView: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var changePhotoButton: UIButton!

    var imagePicker = UIImagePickerController()

    var detailItem: Note? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detailItem = detailItem {
            if let detailDescriptionTextView = detailDescriptionTextView {
                detailDescriptionTextView.text = detailItem.body
                detailDescriptionTextView.editable = editing
                editButton.title = editing ? "Done" : "Edit"
                photoImageView.image = detailItem.photo
            }
            editButton?.enabled = true
            changePhotoButton?.enabled = true
        } else {
            if let detailDescriptionTextView = detailDescriptionTextView {
                detailDescriptionTextView.text = "No note selected"
                photoImageView.image = nil
            }
            editButton?.enabled = false
            changePhotoButton?.enabled = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    // MARK: - Actions

    @IBAction func editButtonTapped(sender: AnyObject) {
        self.setEditing(!editing, animated: true)

        if !editing {
            detailItem?.body = detailDescriptionTextView.text
            delegate?.detailViewController(self, didChangeNote: detailItem!)
        }

        self.configureView()

        if editing {
            detailDescriptionTextView.becomeFirstResponder()
        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "changePhoto" {
            imagePicker = segue.destinationViewController as! UIImagePickerController
            imagePicker.delegate = self
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage

        if selectedImage == nil {
            selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        }

        if let selectedImage = selectedImage {
            detailItem?.photo = selectedImage
            delegate?.detailViewController(self, didChangeNote: detailItem!)
            self.configureView()
        }

        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
