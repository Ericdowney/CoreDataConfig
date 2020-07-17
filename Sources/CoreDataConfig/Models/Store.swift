
import Foundation

// MARK: Data Store

public protocol Store: Equatable, Codable {
    typealias Content = [ModelVersion]
    
    var name: String { get }
    @StoreBuilder var modelVersions: Content { get }
}
