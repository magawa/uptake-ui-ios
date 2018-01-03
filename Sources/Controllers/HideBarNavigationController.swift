import UIKit



extension UIViewController {
  /**
   Called by `HideBarNavigationController` on its child controllers to determine whether the nav bar should be hidden or not.
   
   * Returns: `true` if the nav bar is to be hidden when this controller is at the top of the navigation stack. Otherwise `false` (the default).
   */
  open func shouldHideNavBar() -> Bool {
    return false
  }
}



private class ShouldHideNavBarStrategy: NSObject, UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController, willShow viewControllerToShow: UIViewController, animated: Bool) {
    let shouldHideNavBar = viewControllerToShow.shouldHideNavBar()
    navigationController.setNavigationBarHidden(shouldHideNavBar, animated: animated)
  }
}



/** 
 A navigation controller that interrogates its view controllers as to whether it should hide its nav bar or not.
 
 View controllers that return `true` from the `shouldHideNavBar()` method will cause the nav bar to be hidden when they transition to the top of the navigation stack. Otherwise, the nav bar will be shown as per usual.
 */
open class HideBarNavigationController: UINavigationController {
  fileprivate let hideStrategy = ShouldHideNavBarStrategy()
  
  
  /// :nodoc:
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  
  /// :nodoc:
  public override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    sharedInit()
  }
  
  
  /// :nodoc:
  public override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
    super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    sharedInit()
  }
  
  
  /// :nodoc:
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    sharedInit()
  }
}



private extension HideBarNavigationController {
  func sharedInit() {
    delegate = hideStrategy
  }
}
