//
//  Meal.swift
//  RxFoodTracker
//
//  Created by Bryan Konowitz on 1/8/16.
//  Copyright © 2016 Bryan Konowitz. All rights reserved.
//

import UIKit

class Meal {
  var name: String
  var image: UIImage?
  var rating: Int
  
  init?(name: String, rating: Int, image: UIImage?) {
    self.name = name
    self.rating = rating
    self.image = image
    
    guard !name.isEmpty && rating >= 0 else { return nil }
  }
}