import UIKit



public extension UIApplication {
  /** 
   Attempts to present a view controller on top of all other views.
   
   * Note: This works by finding the top controller being presented in the view controller hierarchy (or the `window`'s root view controller if there are none). This normally results int he correct behavior, but consider what will happen if your modals sprout modals before using this.
   
   * Parameter vc: The view controller to present.
   
   * Parameter f: *Optional.* A closure to execute once presentation has completed.
   */
  func presentOnTop(_ vc: UIViewController, completion f: (()->Void)? = nil) {
    guard let root = keyWindow?.rootViewController else {
      return
    }
    
    var edge = root
    while let presented = edge.presentedViewController {
      edge = presented
    }
    
    edge.present(vc, animated: true, completion: f)
  }
}
