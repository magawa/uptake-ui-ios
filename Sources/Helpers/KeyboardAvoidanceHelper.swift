import UIKit


/// Helper class abstracting keyboard change notifications into a simpler interface.
public class KeyboardAvoidanceHelper: NSObject {
  /// The interface for delegate callbacks.
  public struct Delegate {
    /**
     Called whenever the keyboard height changes, passing the new height, the interval it will take the keyboard to reach it, and the animation curve it will use to get there.
     
     * Note: The keyboard usually changes height because is being hidden or shown. But it can also be because of changing lanugage (chinese), changing type (emoji), showing the "autocomplete" bar, &c.
     
     * Wanring: This helper holds a strong reference to this value, so any closure assigned to is should almost certainly capture `self` as a weak reference.
     */
    public var didChangeHeight: (CGFloat, TimeInterval?,  UIViewAnimationCurve?)->Void = { _,_,_  in }
  }
  
  
  /// The delegate callbacks called when something interesting happens to the keyboard.
  public var delegate = Delegate()
  
  
  /// :nodoc:
  public override init() {
    super.init()
    NotificationCenter.default.addObserver(self, selector: #selector(willShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(willHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
}



internal extension KeyboardAvoidanceHelper {
  @objc func willShow(_ note: Notification) {
    let (height, duration, curve) = Helper.unpackNotification(note)
    guard let someHeight = height else {
      return
    }
    delegate.didChangeHeight(someHeight, duration, curve)
  }
  
  
  @objc func willHide(_ note: Notification) {
    let (_, duration, curve) = Helper.unpackNotification(note)
    delegate.didChangeHeight(0, duration, curve)
  }
}



private enum Helper {
  static func unpackNotification(_ note: Notification) -> (CGFloat?, TimeInterval?, UIViewAnimationCurve?) {
    let info = note.userInfo
    let frame = info?[UIKeyboardFrameEndUserInfoKey] as? CGRect
    let duration = info?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
    let rawCurve = info?[UIKeyboardAnimationCurveUserInfoKey] as? Int
    let curve: UIViewAnimationCurve? = rawCurve == nil ? nil : UIViewAnimationCurve(rawValue: rawCurve!)
    
    return (frame?.size.height, duration, curve)
  }
}
