import UIKit
import UptakeToolbox



/**
 A data source capable of representing "empty" rows.
 
 * note: Unlike other section data sources, the count of this source's values is not expected to increase over time. Instead, it's size is specified once on init and filled with `nil`s. As data gets loaded, these nils are replaced with actual values. See: `addValues(_:atIndex:)`.
 */
public class SparseSectionDataSource<CellType: NilableResponsibleCell>: SparseSectionDataSourceProtocol {
  /// Title of this section
  public let title: String?
  /// Number of rows in this section
  public let numberOfRows: Int
  public var isEmpty: Bool {
    return numberOfRows == 0
  }
  public var isNotEmpty: Bool {
    return ❗️isEmpty
  }
  private var values: [CellType.ValueObject?]
  private var cellIdentifier: CellIdentifier?
  
  
  /// initializes with a title and the number of rows this source will represent. The number of rows is fixed from this point out and may neither grow nor shrink.
  public init(title: String? = nil, numberOfRows: Int) {
    self.title = title
    self.numberOfRows = numberOfRows
    values = Array(repeating: nil, count: numberOfRows)
  }
}



public extension SparseSectionDataSource {
  /// Returns a cell for a given index path. Note the cell may be asked to represent a `nil` value.
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: findOrRegisterIdentifier(for: tableView).identifier, for: indexPath)
    if let responsibleCell = cell as? CellType {
      responsibleCell.fill(with: values[indexPath.row])
    }
    return cell
  }
  
  
  /**
   Replaces the values at the given index with the new values in the given collection. The intent is to replaces `nil` values with real values after they've loaded, but no guarantees are made around this.
   
   * warning: The store's `numberOfRows` must be greater than or equal to `valueObjects.count` + `index` or this will overflow the store's storage (causing a crash).
   
   * returns: Range modified by this operation (for passing on to `UITableView.reloadRows(at:with:)`.
   */
  @discardableResult func addValues(_ valueObjects: [CellType.ValueObject?], at rowIndex: Int) -> CountableRange<Int> {
    let range = rowIndex ..< (rowIndex + valueObjects.count)
    values.replaceSubrange(range, with: valueObjects)
    return range
  }
  
  
  /// Returns which of the given row indices have no values.
  func missingRows(from rowIndices: [Int]) -> [Int] {
    return rowIndices.filter { values[$0] == nil }
  }
}



private extension SparseSectionDataSource {
  func findOrRegisterIdentifier(for table: UITableView) -> CellIdentifier {
    switch cellIdentifier {
    case let id?:
      return id
    case nil:
      let id = CellType.register(with: table)
      cellIdentifier = id
      return id
    }
  }
}

