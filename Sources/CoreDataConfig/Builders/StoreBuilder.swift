
import Foundation

@_functionBuilder
public struct StoreBuilder {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    public static func buildBlock(_ items: EntityWrapper...) -> Model {
        Model(entities: items.map(\.entity))
    }
}
