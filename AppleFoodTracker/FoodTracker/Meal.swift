import UIKit

class Meal: NSObject, NSCoding {
  var name: String
  var rating: Int
  var image: UIImage?
  
  struct PropertyKey {
    static let nameKey = "name"
    static let ratingKey = "rating"
    static let imageKey = "image"
  }
  
  static let DocumentsDirectory = NSFileManager()
    .URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
  static let ArchiveURL = DocumentsDirectory
    .URLByAppendingPathComponent("meals")
  
  init?(name: String, rating: Int, image: UIImage?) {
    self.name = name
    self.rating = rating
    self.image = image
    super.init()
    
    if name.isEmpty || rating < 0 {
      return nil
    }
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
    aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    aCoder.encodeObject(image, forKey: PropertyKey.imageKey)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
    let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
    let image = aDecoder.decodeObjectForKey(PropertyKey.imageKey) as? UIImage
    
    self.init(name: name, rating: rating, image: image)
  }
}