import Foundation



public struct CellIdentifier {
  public let identifier: String
  
  
  public init(_ identifier: String) {
    self.identifier = identifier
  }
  
  
  public init(type: Any.Type) {
    self.init(String(describing: type))
  }
  
  
  public init(instance: Any) {
    self.init(String(describing: type(of: instance)))
  }
}
