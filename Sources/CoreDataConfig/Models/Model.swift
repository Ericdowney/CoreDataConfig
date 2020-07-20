
import Foundation

// MARK: Model

public struct Model: Equatable, Codable {
    
    // MARK: - Properties
    
    public var configurationName: String
    public var entities: [Entity]
    
    // MARK: - Lifecycle
    
    public init(configurationName: String = "Default", @EntityBuilder _ builder: () -> [Entity]) {
        self.configurationName = configurationName
        self.entities = builder()
    }
    
    init(configurationName: String = "Default", entities: [Entity]) {
        self.configurationName = configurationName
        self.entities = entities
    }
    
    // MARK: - Methods
}
