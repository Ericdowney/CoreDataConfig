
import Foundation

@_functionBuilder
public struct EntityBuilder {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    public static func buildBlock<Wrapper: EntityWrapper>(_ items: Wrapper...) -> [Entity<Wrapper.Identifier>] {
        items.map(\.entity)
    }
}
