//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Bryan Konowitz on 1/7/16.
//  Copyright © 2016 Bryan Konowitz. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
  var meals = [Meal]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.leftBarButtonItem = editButtonItem()
    if let savedMeals = loadMeals() {
      meals += savedMeals
    } else {
      loadSampleMeals()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return meals.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "MealTableViewCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
    let meal = meals[indexPath.row]
    
    cell.nameLabel.text = meal.name
    cell.photoImageView.image = meal.image
    cell.ratingControl.rating = meal.rating
    
    return cell
  }
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      // Delete the row from the data source
      meals.removeAtIndex(indexPath.row)
      saveMeals()
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }

  
  func loadSampleMeals() {
    let photo1 = UIImage(named: "veggieBowl")!
    let meal1 = Meal(name: "Caprese Salad", rating: 4, image: photo1)!
    
    let photo2 = UIImage(named: "grilledChicken")!
    let meal2 = Meal(name: "Chicken and Potatoes", rating: 5, image: photo2)!
    
    let photo3 = UIImage(named: "pasta")!
    let meal3 = Meal(name: "Pasta with Meatballs", rating: 3, image: photo3)!
    
    meals += [meal1, meal2, meal3]
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowMealDetail" {
      let mealDetailViewController = segue.destinationViewController as! MealViewController
      if let selectedMeal = sender as? MealTableViewCell {
        let indexPath = tableView.indexPathForCell(selectedMeal)!
        mealDetailViewController.meal = meals[indexPath.row]
      }
    } else if segue.identifier == "AddMealItem" {
      print("adding new meal")
    }
  }
  
  @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal {
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
        meals[selectedIndexPath.row] = meal
        tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
      } else {
        let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
        meals.append(meal)
        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
      }
      saveMeals()
    }
  }
  
  func saveMeals() {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals,
      toFile: Meal.ArchiveURL.path!)
    if !isSuccessfulSave {
      print("Failed while saving meals")
    }
  }
  
  func loadMeals() -> [Meal]? {
    return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
  }
}
