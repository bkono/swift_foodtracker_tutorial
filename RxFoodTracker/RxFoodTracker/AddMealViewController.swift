//
//  ViewController.swift
//  RxFoodTracker
//
//  Created by Bryan Konowitz on 1/8/16.
//  Copyright © 2016 Bryan Konowitz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddMealViewController: UIViewController {

  @IBOutlet weak var mealNameLabel: UILabel!
  @IBOutlet weak var mealNameField: UITextField!
  @IBOutlet weak var resetMealNameButton: UIButton!
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    mealNameField.rx_text
      .filter { !$0.isEmpty }
      .bindTo(mealNameLabel.rx_text)
      .addDisposableTo(disposeBag)
    
    mealNameField.rx_text
      .map { !$0.isEmpty }
      .bindTo(resetMealNameButton.rx_enabled)
      .addDisposableTo(disposeBag)
    
    resetMealNameButton.rx_tap
      .subscribeNext { _ in
        self.mealNameField.rx_text.onNext("")
        self.mealNameLabel.rx_text.onNext("Meal Name")
      }
      .addDisposableTo(disposeBag)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

