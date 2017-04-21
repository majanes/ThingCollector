//
//  ThingViewController.swift
//  ThingCollector
//
//  Created by Mark Janes on 16/04/2017.
//  Copyright © 2017 The Light Machine. All rights reserved.
//

import UIKit

class ThingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var thingImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addupdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var thing : Thing? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if thing != nil {
            titleTextField.text = thing!.title
            thingImageView.image = UIImage(data: thing!.image as! Data)
            addupdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        thingImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if thing != nil {
            thing!.title = titleTextField.text
            thing!.image = UIImagePNGRepresentation(thingImageView.image!) as NSData?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let thing = Thing(context: context)
            thing.title = titleTextField.text
            thing.image = UIImagePNGRepresentation(thingImageView.image!) as NSData?
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }

        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(thing!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
}
