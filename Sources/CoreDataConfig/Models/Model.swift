
import Foundation

// MARK: Model

public struct Model<Identifier: EntityIdentifiable>: Equatable, Codable {
    
    // MARK: - Properties
    
    public var configurationName: String
    public var entities: [Entity<Identifier>]
    
    // MARK: - Lifecycle
    
    public init(configurationName: String = "Default", @EntityBuilder _ entities: () -> [Entity<Identifier>]) {
        self.configurationName = configurationName
        self.entities = entities()
    }
    
//    init(configurationName: String = "Default", entities: [Entity<Identifier>]) {
//        self.configurationName = configurationName
//        self.entities = entities
//    }
    
    // MARK: - Methods
}
