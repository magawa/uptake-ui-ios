import UIKit
import XCTest
import UptakeUI
import UptakeToolbox


class SparseSectionDataSourceTests: XCTestCase {
  class MockCell: UITableViewCell, NilableResponsibleCell {
    var value: Int?
    
    static func register(with table: UITableView) -> CellIdentifier {
      table.register(MockCell.self, forCellReuseIdentifier: "mockCell")
      return CellIdentifier("mockCell")
    }
    
    func fill(with value: Int?) {
      self.value = value
    }
  }
  
  
  func testTitle() {
    let title = SparseSectionDataSource<MockCell>(title: "foo", numberOfRows: 0).title
    XCTAssertEqual(title, "foo")
    let noTitle = SparseSectionDataSource<MockCell>(numberOfRows: 0).title
    XCTAssertNil(noTitle)
  }
  
  
  func testCount() {
    let noRows = SparseSectionDataSource<MockCell>(numberOfRows: 0)
    XCTAssertEqual(noRows.numberOfRows, 0)
    XCTAssert(noRows.isEmpty)
    XCTAssertFalse(noRows.isNotEmpty)
    
    let someRows = SparseSectionDataSource<MockCell>(numberOfRows: 42)
    XCTAssertEqual(someRows.numberOfRows, 42)
    XCTAssert(someRows.isNotEmpty)
    XCTAssertFalse(someRows.isEmpty)
  }
  
  
  func testValues() {
    let placeholder = UITableView()
    with(SparseSectionDataSource<MockCell>(numberOfRows: 42)) { ds in
      let nilCells = (0..<ds.numberOfRows).map {
        return ds.tableView(placeholder, cellForRowAt: IndexPath(row: $0, section: 0)) as! MockCell
      }
      XCTAssertEqual(nilCells.count, 42)
      nilCells.forEach {
        XCTAssertNil($0.value)
      }
      
      let updatedIndices = ds.addValues([1,2,3], at: 3)
      
      XCTAssertEqual(updatedIndices, 3..<6)
      
      let someCells = (0..<10).map {
        return ds.tableView(placeholder, cellForRowAt: IndexPath(row: $0, section: 0)) as! MockCell
      }
      
      XCTAssertNil(someCells[2].value)
      XCTAssertEqual(someCells[3].value, 1)
      XCTAssertEqual(someCells[4].value, 2)
      XCTAssertEqual(someCells[5].value, 3)
      XCTAssertNil(someCells[6].value)
    }
  }
}

