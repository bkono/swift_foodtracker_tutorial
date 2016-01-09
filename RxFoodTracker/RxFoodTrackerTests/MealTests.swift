import RxSwift
import RxTests
import XCTest
@testable import RxFoodTracker

class MealTests: XCTestCase {
  func testMealInitSucceedsWithValidParams() {
    let potentialItem = Meal(name: "valid meal", rating: 3, image: nil)
    XCTAssertNotNil(potentialItem)
  }
  
  func testMealInitRejectsEmptyName() {
    let potentialItem = Meal(name: "", rating: 5, image: nil)
    XCTAssertNil(potentialItem, "Empty name is invalid")
  }
  
  func testMealInitRejectsNegativeRatings() {
    let potentialItem = Meal(name: "bad rating", rating: -1, image: nil)
    XCTAssertNil(potentialItem, "Negative ratings are invalid")
  }

}