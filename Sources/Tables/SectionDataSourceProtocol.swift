import UIKit



public protocol SectionDataSourceProtocol {
  var title: String? {get}
  var numberOfRows: Int {get}
  var isEmpty: Bool {get}
  var isNotEmpty: Bool {get}
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}
