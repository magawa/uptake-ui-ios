import Foundation



public protocol SparseSectionDataSourceProtocol: SectionDataSourceProtocol {
  func missingRows(from rowIndices: [Int]) -> [Int]
}
