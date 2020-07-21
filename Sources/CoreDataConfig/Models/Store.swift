
import Foundation

public protocol Store: Equatable, Codable {
    associatedtype Identifier: EntityIdentifiable
    
    var name: String { get }
    var model: Model<Identifier> { get }
}
