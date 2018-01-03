import UIKit
import UptakeToolbox



class CircleSpinnerView: UIView {
  fileprivate enum K {
    static let gradientName = "CircleSpinnerGradient"
  }
  
  
  internal var color: UIColor = .black {
    didSet {
      setNeedsDisplay()
    }
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
}



internal extension CircleSpinnerView {
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 50, height: 50)
  }
  
  
  override func draw(_ rect: CGRect) {
    let lineWidth: CGFloat = 2.0
    let rect = bounds.insetBy(dx: lineWidth/2.0, dy: lineWidth/2.0)
    color.setStroke()
    let path = UIBezierPath(ovalIn: rect)
    path.lineWidth = 2.0
    path.stroke()
  }
  
  
  override func layoutSubviews() {
    layer.mask = makeMaskLayer(size: bounds.size)
    layer.mask?.add(makeAnimation(), forKey: nil)
  }
}



private extension CircleSpinnerView {
  func makeAnimation() -> CAAnimation {
    return given(CABasicAnimation(keyPath: "transform.rotation")) {
      $0.fromValue = 0
      $0.toValue = CGFloat.pi * 2.0
      $0.duration = 1
      $0.repeatCount = Float.greatestFiniteMagnitude
    }
  }
  
  
  func sharedInit() {
    isOpaque = false
    backgroundColor = .clear
  }
  
  
  func makeMaskLayer(size: CGSize) -> CALayer {
    return given(CALayer()) {
      $0.frame = CGRect(origin: CGPoint.zero, size: size)
      if let image = UIImage(named: K.gradientName, in: Bundle(for: type(of: self)), compatibleWith: nil)?.cgImage {
        $0.contents = image
      }
    }
  }
}
