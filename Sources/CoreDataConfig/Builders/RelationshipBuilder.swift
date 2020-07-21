
import Foundation

@_functionBuilder
public struct RelationshipBuilder {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    public static func buildBlock<Identifier: EntityIdentifiable>(_ items: Relationship<Identifier>...) -> [Relationship<Identifier>] {
        items
    }
}
