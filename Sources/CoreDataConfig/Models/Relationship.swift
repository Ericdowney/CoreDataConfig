
import Foundation

public struct Relationship: Equatable, Codable {
    public enum RelationshipType: Int, Codable {
        case toOne, toMany
    }
    public enum DeleteRule: Int, Codable {
        case noAction, nullify, cascade, deny
    }
    public struct Arrangement: Equatable, Codable {
        var isOrdered: Bool
        var lowerBound: Int?
        var upperBound: Int?
        var isMinimum: Bool?
        var isMaximum: Bool?
        
        public init(isOrdered: Bool, lowerBound: Int? = nil, upperBound: Int? = nil, isMinimum: Bool? = nil, isMaximum: Bool? = nil) {
            self.isOrdered = isOrdered
            self.lowerBound = lowerBound
            self.upperBound = upperBound
            self.isMinimum = isMinimum
            self.isMaximum = isMaximum
        }
    }
    
    // MARK: - Properties
    
    var name: String
    var entityName: String
    var type: RelationshipType
    var isTransient: Bool
    var isOptional: Bool
    var deleteRule: DeleteRule
    var arrangement: Arrangement
    var indexInSpotlight: Bool
    
    // MARK: - Lifecycle
    
    public init(_ name: String,
                entity: String,
                type: RelationshipType,
                isTransient: Bool = false,
                isOptional: Bool = true,
                deleteRule: DeleteRule = .nullify,
                arrangement: Arrangement = .init(isOrdered: false),
                indexInSpotlight: Bool = false) {
        self.name = name
        self.entityName = entity
        self.type = type
        self.isTransient = isTransient
        self.isOptional = isOptional
        self.deleteRule = deleteRule
        self.arrangement = arrangement
        self.indexInSpotlight = indexInSpotlight
    }
    
    // MARK: - Methods
    
    public func isTransient(_ value: Bool) -> Self {
        return .init(name,
                     entity: entityName,
                     type: type,
                     isTransient: value,
                     isOptional: isOptional,
                     deleteRule: deleteRule,
                     arrangement: arrangement,
                     indexInSpotlight: indexInSpotlight)
    }
    
    public func isOptional(_ value: Bool) -> Self {
        return .init(name,
                     entity: entityName,
                     type: type,
                     isTransient: isTransient,
                     isOptional: value,
                     deleteRule: deleteRule,
                     arrangement: arrangement,
                     indexInSpotlight: indexInSpotlight)
    }
    
    public func deleteRule(_ value: DeleteRule) -> Self {
        return .init(name,
                     entity: entityName,
                     type: type,
                     isTransient: isTransient,
                     isOptional: isOptional,
                     deleteRule: value,
                     arrangement: arrangement,
                     indexInSpotlight: indexInSpotlight)
    }
    
    public func arrangement(_ value: Arrangement) -> Self {
        return .init(name,
                     entity: entityName,
                     type: type,
                     isTransient: isTransient,
                     isOptional: isOptional,
                     deleteRule: deleteRule,
                     arrangement: value,
                     indexInSpotlight: indexInSpotlight)
    }
    
    public func arrangement(isOrdered: Bool, lowerBound: Int? = nil, upperBound: Int? = nil, isMinimum: Bool? = nil, isMaximum: Bool? = nil) -> Self {
        return .init(name,
                     entity: entityName,
                     type: type,
                     isTransient: isTransient,
                     isOptional: isOptional,
                     deleteRule: deleteRule,
                     arrangement: .init(isOrdered: isOrdered, lowerBound: lowerBound, upperBound: upperBound, isMinimum: isMinimum, isMaximum: isMaximum),
                     indexInSpotlight: indexInSpotlight)
    }
    
    public func indexInSpotlight(_ value: Bool) -> Self {
        return .init(name,
                     entity: entityName,
                     type: type,
                     isTransient: isTransient,
                     isOptional: isOptional,
                     deleteRule: deleteRule,
                     arrangement: arrangement,
                     indexInSpotlight: value)
    }
}
