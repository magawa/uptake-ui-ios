import UIKit
import UptakeToolbox



/**
 A container view controller that shows only the "selected" child view controller at any given time.
 
 This differs from `UITabBarController` in two key ways that make it ideal for embedding in other controllers:
 
 1. Only the selected view controller is live in memory at any given time.
 1. There is no interface bundled in for switching between selected controllers (though see `SegmentedTabViewController` for an example adding this).
 
 * Seealso: `SegmentedTabViewController`
 */
public class EmbeddedTabViewController: UIViewController {
    fileprivate var selectedConstraints: [NSLayoutConstraint] = []

    
    /**
     The collection of view controllers managed by `EmbeddedTabViewController`. Zero or one of these will be loaded and displayed depending on the value of `selectedIndex`. The rest will be unloaded from both the view and view controller hierarchies.
     
     This collection may be mutated or replaced at any time. Any time it's modified, the first view controller in the collection is selected (unless the collection is empty, in which case the selection is set to `nil`)
     
     * Seealso: `selectedIndex`
     */
    public var viewControllers: [UIViewController] = [] {
        didSet {
            guard viewControllers.isNotEmpty else {
                selectedIndex = nil
                return
            }
            selectedIndex = 0
        }
    }
    
    
    /**
     The index of the view controller to display. Changing this value unloads the currently selected view controller from its view and controller hierarchies, replacing it with the view controller at the given index. Setting this property to `nil` removes all controllers and displays none.
     
     * Warning: setting this to an index beyond the range of the `viewControllers` collection will trap.
     */
    public var selectedIndex: Int? {
        willSet {
            removeControllers()
        }
        didSet {
            addSelectedController()
        }
    }
    
    
  
    /// The number of view controllers managed by `EmbeddedTabViewController`.
    public var numberOfTabs: Int {
        return viewControllers.count
    }
}



private extension EmbeddedTabViewController {
    func removeControllers() {
        childViewControllers.forEach {
            extract($0, constraints: selectedConstraints)
            selectedConstraints = []
        }
    }
    
    
    func addSelectedController() {
        guard let someIndex = selectedIndex else {
            return
        }
        selectedConstraints = embedAndMaximize(viewControllers[someIndex])
    }
}
