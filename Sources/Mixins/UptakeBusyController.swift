import UIKit
import UptakeToolbox



internal class UptakeBusyController: BusyController {
  weak var spinner: UIImageView?
  
  internal override func viewDidLoad() {
    let effect = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    view.addSubview(effect, mode: .fullFrame)
    
    spinner = given(UIImageView(image: Helper.makeAnimatedImage())) {
      $0.backgroundColor = .clear
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
      NSLayoutConstraint.activate([
        $0.widthAnchor.constraint(equalToConstant: 40),
        $0.heightAnchor.constraint(equalToConstant: 40),
        $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        $0.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
  }
  
  
  private enum Helper {
    static func makeAnimatedImage() -> UIImage {
      let images = (0..<40)
        .map { "loader\($0)" }
        .flatMap { UIImage(named: $0, in: Bundle(for: BusyController.self), compatibleWith: nil) }
      
      guard
        images.isNotEmpty,
        let animatedImage = UIImage.animatedImage(with: images, duration: 1.5) else {
          fatalError("Unabel to find animated assets.")
      }
      return animatedImage
    }
  }
}
