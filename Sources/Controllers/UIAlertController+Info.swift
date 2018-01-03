import UIKit
import UptakeToolbox



public extension UIAlertController {
  /**
   Convienience constructor to make a simple informational alert (one that only displays a message and a single "OK" button that dismisses it).
   
   * Parameter title: The title to display across the top of the alert.
   
   * Parameter message: The message to display in the alert
   
   * Returns: An alert controller ready to be presented.
   */
  static func makeInfo(title: String, message: String) -> UIAlertController {
    return given(UIAlertController(title: title, message: message, preferredStyle: .alert)) {
      $0.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    }
  }
}
