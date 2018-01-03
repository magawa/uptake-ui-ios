import UIKit
import UptakeToolbox




public extension UIView {
  /// The rules determining what set of constraints get applied to a view.
  public enum FillMode {
    /// Expand the view to fill the entirety of its parent's frame.
    case fullFrame
    
    /// Constrain the view to a centered square as wide/tall as the smallest dimension of its parent.
    case aspectFit
  }

  
  /**
   Like `UIView.addSubview(_:)`, except it also applies constrains in line with the given `FillMode`.
   
   * Parameter child: The view to add to the receiver's view hierarchy.
   
   * Parameter mode: The `FillMode` used to determine what constraints to apply.
   */
  func addSubview(_ child: UIView, mode: FillMode) {
    child.translatesAutoresizingMaskIntoConstraints = false
    addSubview(child)
    switch mode {
    case .fullFrame:
      Helper.applyFullFrameConstraints(from: child, to: self)
    case .aspectFit:
      Helper.applyAspectFitConstraints(from: child, to: self)
    }
  }
}



private enum Helper {
  static func applyFullFrameConstraints(from child: UIView, to parent: UIView) {
    NSLayoutConstraint.activate([
      child.topAnchor.constraint(equalTo: parent.topAnchor),
      child.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
      child.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
      child.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
    ])
  }
  
  
  static func applyAspectFitConstraints(from child: UIView, to parent: UIView) {
    NSLayoutConstraint.activate([
      given(child.widthAnchor.constraint(equalTo: parent.widthAnchor)) { $0.priority = UILayoutPriority(rawValue: 999) },
      given(child.heightAnchor.constraint(equalTo: parent.heightAnchor)) { $0.priority = UILayoutPriority(rawValue: 999) },
      child.widthAnchor.constraint(lessThanOrEqualTo: parent.widthAnchor),
      child.heightAnchor.constraint(lessThanOrEqualTo: parent.heightAnchor),
      child.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
      child.centerYAnchor.constraint(equalTo: parent.centerYAnchor),
      child.widthAnchor.constraint(equalTo: child.heightAnchor)
    ])
  }
}
