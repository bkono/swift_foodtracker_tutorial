//
//  ViewController.swift
//  FoodTracker
//
//  Created by Bryan Konowitz on 1/6/16.
//  Copyright © 2016 Bryan Konowitz. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  var meal: Meal?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nameTextField.delegate = self
    
    if let meal = self.meal {
      navigationItem.title = meal.name
      nameTextField.text = meal.name
      photoImageView.image = meal.image
      ratingControl.rating = meal.rating
    }
    
    checkValidMealName()
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    saveButton.enabled = false
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    checkValidMealName()
    navigationItem.title = textField.text
  }
  
  func checkValidMealName() {
    let text = nameTextField.text ?? ""
    saveButton.enabled = !text.isEmpty
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    photoImageView.image = image
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if sender === saveButton {
      let name = nameTextField.text ?? ""
      let image = photoImageView.image
      let rating = ratingControl.rating
      meal = Meal(name: name, rating: rating, image: image)
    }
  }
  @IBAction func cancel(sender: UIBarButtonItem) {
    if presentingViewController is UINavigationController {
      dismissViewControllerAnimated(true, completion: nil)
    } else {
      navigationController!.popViewControllerAnimated(true)
    }
  }
  
  @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
    nameTextField.resignFirstResponder()
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .PhotoLibrary
    imagePicker.delegate = self
    presentViewController(imagePicker, animated: true, completion: nil)
  }
}

