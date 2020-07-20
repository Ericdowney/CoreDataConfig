
import Foundation

// MARK: Store

public protocol Store: Equatable, Codable {
    
    var name: String { get }
    @StoreBuilder var model: Model { get }
}
