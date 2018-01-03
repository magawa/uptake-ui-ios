import UIKit
import UptakeToolbox



/**
 A container view controller that loads only the "selected" view controller at any given time. It incorporates a `UISegmentedControl` across the top of its frame to manage this selection.
 
 * Note: The title of the segments is taken from the view controllers' `title` property, which can be set directly or inferred from `navigationItem.title`.
 */
public class SegmentedTabViewController: UIViewController {
  fileprivate let segmentedControl = UISegmentedControl(frame: CGRect.zero)
  fileprivate let tabController = EmbeddedTabViewController()

  
  /**
   The collection of view controllers managed by the receiver. For each view controller added here, a new segment will be added to the `UISegmentedControl` with a title equal to its `title` or `navigationItem.title`.
   
   This collection may be mutated or replaced at any time. Any time it's modified, the first view controller in the collection is selected.
   */
  public var viewControllers: [UIViewController] {
    get {
      return tabController.viewControllers
    }
    set {
      tabController.viewControllers = newValue
      Helper.updateSegments(segmentedControl, with: newValue, index: tabController.selectedIndex)
    }
  }
  

  /// The number of view controllers managed by the receiver.
  var numberOfTabs: Int {
    return tabController.numberOfTabs
  }
}



public extension SegmentedTabViewController {
    /// :nodoc:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        with(addSegmentContainer()) {
            Helper.addSegmentedControl(segmentedControl, to: $0)
            embed(tabController, withConstraints: [
                tabController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tabController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tabController.view.topAnchor.constraint(equalTo: $0.bottomAnchor),
                tabController.view.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
            ])
        }
        segmentedControl.addTarget(self, action: #selector(selectedIndexChanged(sender:)), for: .valueChanged)
    }
}



internal extension SegmentedTabViewController {
    @objc func selectedIndexChanged(sender: UISegmentedControl) {
        tabController.selectedIndex = sender.selectedSegmentIndex
    }
}



private extension SegmentedTabViewController {
    func addSegmentContainer() -> UIView {
        return given(UIView(frame: CGRect.zero)){
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor)
            ])
        }
    }
}



private enum Helper {
    static func addSegmentedControl(_ control: UISegmentedControl, to box: UIView){
        with(control) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            box.addSubview($0)
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: box.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: box.trailingAnchor, constant: -16),
                $0.topAnchor.constraint(equalTo: box.topAnchor, constant: 8),
                $0.bottomAnchor.constraint(equalTo: box.bottomAnchor, constant: -8),
                ])
        }
    }
    
    
    static func updateSegments(_ segmentedControl: UISegmentedControl, with viewControllers: [UIViewController], index: Int?) {
        viewControllers.map { $0.title }.reversed().forEach {
            segmentedControl.insertSegment(withTitle: $0, at: 0, animated: false)
        }
        segmentedControl.selectedSegmentIndex = index ?? UISegmentedControlNoSegment
    }
}
