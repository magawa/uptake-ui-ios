import UIKit
import UptakeToolbox



/// This is just a namespace for the `apply()` function, which abstracts the application of common Uptake colors and styles via appearance proxies.
public enum AppearanceHelper {
  
  /// Abstracts the application of common Uptake colors and styles via appearance proxies. Call this one on startup (usually in `application(_:didFinishLaunchingWithOptions:)`) to adopt many Uptake styles automatically.
  public static func apply() {
    with(UINavigationBar.appearance()) {
      $0.isTranslucent = false
      $0.barTintColor = .darkBarBackground
      $0.tintColor = .activeTint
      $0.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    with(UITextField.appearance()) {
      $0.tintColor = .activeTint
      $0.keyboardAppearance = .dark
    }
    
    with(UITextView.appearance()) {
      $0.tintColor = .activeTint
    }
    
    with(UISearchBar.appearance()) {
      $0.tintColor = .activeTint
      $0.keyboardAppearance = .dark
    }
  }
}


