
import Foundation

@_functionBuilder
public struct VersionBuilder {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    public static func buildBlock(_ items: Entity...) -> Model {
        Model(entities: items)
    }
    
    public static func buildFunction(_ items: Entity...) -> Model {
        Model(entities: items)
    }
    
    public static func buildIf(_ item: Entity?) -> Model {
        item.map { Model(entities: [$0]) } ?? Model(entities: [])
    }
}
