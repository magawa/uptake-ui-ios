import UIKit


public enum BusyStyle {
  case uptake
  case cat
  

  func makeBusyController() -> BusyController {
    switch self {
    case .uptake:
      return UptakeBusyController()

    case .cat:
      return CATBusyController()
    }
  }
}
