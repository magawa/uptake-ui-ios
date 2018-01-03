import UIKit
import UptakeToolbox



class CATBusyController: BusyController {
  weak var spinner: CircleSpinnerView?
  
  
  internal override func viewDidLoad() {
    let effect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    view.addSubview(effect, mode: .fullFrame)
    
    spinner = given(CircleSpinnerView()) {
      $0.color = .catRed
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
      NSLayoutConstraint.activate([
        $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        $0.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
  }
}
