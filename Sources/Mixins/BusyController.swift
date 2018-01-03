import UIKit
import UptakeToolbox



internal class BusyController: UIViewController {
  internal var parentConstraints: [NSLayoutConstraint] = []
  
  
  internal required init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  
  internal required init?(coder aDecoder: NSCoder) {
    fatalError("Do not load from NIB.")
  }
  
  
}
