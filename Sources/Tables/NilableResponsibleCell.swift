import UIKit



/// Identical to `ResponsibleCell` except it can `fill` with `nil`.
// There's probably some way to do this with composed protocols, but it's small enough I just copy/pasted.
public protocol NilableResponsibleCell {
  associatedtype ValueObject
  static func register(with table: UITableView) -> CellIdentifier
  func fill(with value: ValueObject?)
}

