import UIKit
import UptakeToolbox



public extension UIViewController {
  /**
   Adds the given view controller to the receiver's `childViewControllers`, performing all the necessary housekeeping, then pinning the given controller's view to edges of the receiver's view.
   
   * Parameter child: The view controller to add to the receiver's `childViewControllers`
   
   * Parameter animated: Whether the addition of the `child`'s view to the receiver's view hierarchy should be animated. If `true` a very basic crossfade is used.
   
   * Returns: The constraints used to pin the given controller's view to the receiver's view. These constraints will need to be removed if the given controller is ever removed from the receiver.
   */
  @discardableResult func embedAndMaximize(_ child: UIViewController, useLayoutGuides: Bool = true, animated: Bool = false) -> [NSLayoutConstraint] {
    let constraints = Helper.makeMaximizedConstraints(from: child, to: self, useLayoutGuides: useLayoutGuides)
    embed(child, withConstraints: constraints, animated: animated)
    return constraints
  }
  
  
  /**
   Adds the given view controller to the receiver's `childViewControllers`, performing all the necessary housekeeping, then applying the given constraints.
   
   * Parameter child: The view controller to add to the receiver's `childViewControllers`
   
   * Parameter constraints: The constraints to apply. These will usually specify the given controller's view's relation to the receiver's view. These constraints should not be active at call-time (activating constraints between views not in the same view heirarchy will trap) and will have been activated by the time the call returns.
   
   * Parameter animated: Whether the addition of `child`'s view to the receiver's view hierarchy should be animated. If `true` a very basic crossfade is used.
   */
  func embed(_ child: UIViewController, withConstraints constraints: [NSLayoutConstraint], animated: Bool = false) {
    let f = { self.view.addSubview(child.view) }
    addChildViewController(child)
    
    if animated {
      UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: f, completion: nil)
    } else {
      f()
    }
    
    child.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(constraints)
    child.didMove(toParentViewController: self)
  }
  
  
  /**
   Removes a given view controller from the receiver's controller hierarchry.
   
   * Parameter child: The view controller to be removed from the receiver's `childViewControllers`. `child`'s view will also be removed from the view heirarchy.
   
   * Parameter constraints: Any constraints between `child`'s view and the receiver's. These are normally those passed into `embed` or returned from `embedAndMaximize`. They will be disabled before any views are removed, preventing autolayout issues.
   
   * Parameter animated: Whether the removal of `child`'s view from the receiver's view hierarchy should be animated. If `true` a very basic crossfade is used.
   */
  func extract(_ child: UIViewController, constraints: [NSLayoutConstraint] = [], animated: Bool = false) {
    let f = { child.view.removeFromSuperview() }
    child.willMove(toParentViewController: nil)
    NSLayoutConstraint.deactivate(constraints)
    
    if animated {
      UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: f, completion: nil)
    } else {
      f()
    }
    child.removeFromParentViewController()
  }
}



private enum Helper {
  static func makeMaximizedConstraints(from child: UIViewController, to parent: UIViewController, useLayoutGuides: Bool) -> [NSLayoutConstraint] {
    return [
      child.view.topAnchor.constraint(equalTo: useLayoutGuides ? parent.topLayoutGuide.bottomAnchor: parent.view.topAnchor),
      child.view.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor),
      child.view.trailingAnchor.constraint(equalTo: parent.view.trailingAnchor),
      child.view.bottomAnchor.constraint(equalTo: useLayoutGuides ? parent.bottomLayoutGuide.topAnchor : parent.view.bottomAnchor),
    ]
  }
}
