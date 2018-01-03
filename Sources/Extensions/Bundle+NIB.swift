import UIKit



public extension Bundle {
  /// Errors that may occur when loading a NIB.
  enum NIB: Error {
    /// The NIB doesn't exist or couldn't be read.
    case loadFailure
    
    /// The NIB was loaded, but contains no objects.
    case noObjects
    
    /// The first object in the NIB could not be cast to the expected type.
    case invalidType
  }
  
  
  /**
   Loads a NIB from the bundle of the given class (or `main` by default), taking its first object and returning it cast it to the expected type.
   
   * Parameter nibName: The name of the NIB to load.
   
   * Parameter owner: *Optional.* The owner to assign to the nib, if any.
   
   * Parameter bundleClass: *Optional.* The bundle contining `bundleClass` will be searched for NIB `nibName`. If no `bundleClass` is given, the `main` bundle will be used.
   
   * Returns: The first object of the loaded nib, cast as expected.
   
   * Throws: `Bundle.NIB`
   */
  public static func castFirstObjectOf<T>(_ nibName: String, owner: Any? = nil, bundleClass: AnyClass? = nil) throws -> T {
    return try Bundle.mainOrClass(bundleClass).castObjectFrom(nibName, owner: owner)
  }
}



private extension Bundle {
  static func mainOrClass(_ bundleClass: AnyClass?) -> Bundle {
    let bundle: Bundle
    switch bundleClass {
    case let b?:
      bundle = Bundle(for: b)
    case nil:
      bundle = Bundle.main
    }
    return bundle
  }
  
  
  func castObjectFrom<T>(_ nibName: String, owner: Any?) throws -> T {
    guard let objects = self.loadNibNamed(nibName, owner: owner, options: nil) else {
      throw NIB.loadFailure
    }
    
    guard let object = objects.first else {
      throw NIB.noObjects
    }
    
    guard let type = object as? T else {
      throw NIB.invalidType
    }
    
    return type
  }
}
