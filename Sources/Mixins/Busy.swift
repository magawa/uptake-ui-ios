import UIKit
import UptakeToolbox


/** 
 A mixin adding "loading screen" functionality to controllers that conform to it. No implementation needed (implementations of the below are added via extension)
 
 This is the default, Uptake-branded version.
 
 - Seealso: CATBusy
 
 - Note: This works by adding a child view controller and a view to the current view controller's hierarchy. If, for whatever reason, the view heierarchy is restricted by the target controller (`UITableViewControllers` come to mind) the busy view won't show. There are a number of work-arounds for this, such as using `Busy` on a controller higher up in the stack (`UINavigationController`, for example), or using a `UIViewController` holding (for example) a table view rather than a micro-managing `UITableViewController`.
 */
public protocol Busy: class {
  /// Reflect whether the busy view of a controller is currently being displayed. Setting this will cause the busy view to be added or remove from the conforming receiver.
  var isBusy: Bool {get set}
  
  /// The opposite of `isBusy`.
  var isNotBusy: Bool {get}
  
  /// Control flow that will set `isBusy = true` on the conforming reciever while `f()` is being evaluated before setting it back to `false`.
  func busyWhile(_ f: ()->Void)
  
  /// :nodoc:
  var busyStyle: BusyStyle {get}
}


/**
 A mixin adding "loading screen" functionality to controllers that conform to it. No implementation needed (implementations of the below are added via extension)
 
 This is the special, CAT-branded version.
 
 - Seealso: Busy
 
 - Note: This works by adding a child view controller and a view to the current view controller's hierarchy. If, for whatever reason, the view heierarchy is restricted by the target controller (`UITableViewControllers` come to mind) the busy view won't show. There are a number of work-arounds for this, such as using `Busy` on a controller higher up in the stack (`UINavigationController`, for example), or using a `UIViewController` holding (for example) a table view rather than a micro-managing `UITableViewController`.
 */
public protocol CATBusy: Busy {}



/// :nodoc:
extension Busy where Self: UIViewController {
  public var isBusy: Bool {
    get {
      return findBusyController() != nil
    }
    set {
      switch newValue {
      case true:
        addBusy()
      case false:
        removeBusy()
      }
    }
  }
  
  
  public var isNotBusy: Bool {
    return ❗️isBusy
  }
  
  
  public func busyWhile(_ f: ()->Void) {
    isBusy = true
    defer { isBusy = false }
    f()
  }
  
  
  public var busyStyle: BusyStyle {
    return .uptake
  }
  
  
  private func findBusyController() -> BusyController? {
    return childViewControllers.first { $0 is BusyController } as? BusyController
  }
  
  
  private func addBusy() {
    guard isNotBusy else {
      return
    }
    
    let busyController = busyStyle.makeBusyController()
    let constraints = embedAndMaximize(busyController, animated: true)
    busyController.parentConstraints = constraints
  }

    
  func removeBusy() {
    guard let child = findBusyController() else {
      return
    }
    
    extract(child, constraints: child.parentConstraints, animated: true)
  }
}



/// :nodoc:
public extension CATBusy {
  public var busyStyle: BusyStyle {
    return .cat
  }
}
