import UIKit
import UptakeToolbox



public class SectionDataSource<CellType: ResponsibleCell>: SectionDataSourceProtocol {
  public var title: String?
  public var values: [CellType.ValueObject] = []
  public var isEmpty: Bool {
    return values.isEmpty
  }
  public var isNotEmpty: Bool {
    return ❗️isEmpty
  }
  public var numberOfRows: Int {
    return values.count
  }
  private var _cellIdentifier: CellIdentifier?
  

  public init(title: String? = nil, values: [CellType.ValueObject] = []) {
    self.title = title
    self.values = values
  }
}



public extension SectionDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: findOrRegisterIdentifier(for: tableView).identifier, for: indexPath)
    if let responsibleCell = cell as? CellType {
      responsibleCell.fill(with: values[indexPath.row])
    }
    return cell
  }
}



private extension SectionDataSource {
  func findOrRegisterIdentifier(for table: UITableView) -> CellIdentifier {
    switch _cellIdentifier {
    case let id?:
      return id
    case nil:
      let id = CellType.register(with: table)
      _cellIdentifier = id
      return id
    }
  }
}
