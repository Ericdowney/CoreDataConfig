
import Foundation
import CoreData

public struct Relationship: Equatable, Codable {
    public enum RelationshipType: Int, Codable {
        case toOne, toMany
    }
    public enum DeleteRule: Int, Codable {
        case noAction, nullify, cascade, deny
        
        var rule: NSDeleteRule {
            switch self {
            case .noAction: return .noActionDeleteRule
            case .nullify: return .nullifyDeleteRule
            case .cascade: return .cascadeDeleteRule
            case .deny: return .denyDeleteRule
            }
        }
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
    var inverse: String
    var type: RelationshipType = .toOne
    var isTransient: Bool = false
    var isOptional: Bool = true
    var deleteRule: DeleteRule = .nullify
    var arrangement: Arrangement = .init(isOrdered: false)
    var indexInSpotlight: Bool = false
    
    // MARK: - Lifecycle
    
    public init(_ name: String,
                entity: String,
                inverse: String) {
        self.name = name
        self.entityName = entity
        self.inverse = inverse
    }
    
    init(_ name: String,
         entity: String,
         inverse: String,
         type: RelationshipType,
         isTransient: Bool,
         isOptional: Bool,
         deleteRule: DeleteRule,
         arrangement: Arrangement,
         indexInSpotlight: Bool) {
        self.name = name
        self.entityName = entity
        self.inverse = inverse
        self.type = type
        self.isTransient = isTransient
        self.isOptional = isOptional
        self.deleteRule = deleteRule
        self.arrangement = arrangement
        self.indexInSpotlight = indexInSpotlight
    }
    
    // MARK: - Methods
    
    public func type(_ value: RelationshipType) -> Self {
        .init(name,
              entity: entityName,
              inverse: inverse,
              type: value,
              isTransient: isTransient,
              isOptional: isOptional,
              deleteRule: deleteRule,
              arrangement: arrangement,
              indexInSpotlight: indexInSpotlight)
    }
    
    public func isTransient(_ value: Bool) -> Self {
        .init(name,
              entity: entityName,
              inverse: inverse,
              type: type,
              isTransient: value,
              isOptional: isOptional,
              deleteRule: deleteRule,
              arrangement: arrangement,
              indexInSpotlight: indexInSpotlight)
    }
    
    public func isOptional(_ value: Bool) -> Self {
        .init(name,
              entity: entityName,
              inverse: inverse,
              type: type,
              isTransient: isTransient,
              isOptional: value,
              deleteRule: deleteRule,
              arrangement: arrangement,
              indexInSpotlight: indexInSpotlight)
    }
    
    public func deleteRule(_ value: DeleteRule) -> Self {
        .init(name,
              entity: entityName,
              inverse: inverse,
              type: type,
              isTransient: isTransient,
              isOptional: isOptional,
              deleteRule: value,
              arrangement: arrangement,
              indexInSpotlight: indexInSpotlight)
    }
    
    public func arrangement(_ value: Arrangement) -> Self {
        .init(name,
              entity: entityName,
              inverse: inverse,
              type: type,
              isTransient: isTransient,
              isOptional: isOptional,
              deleteRule: deleteRule,
              arrangement: value,
              indexInSpotlight: indexInSpotlight)
    }
    
    public func arrangement(isOrdered: Bool, lowerBound: Int? = nil, upperBound: Int? = nil, isMinimum: Bool? = nil, isMaximum: Bool? = nil) -> Self {
        .init(name,
              entity: entityName,
              inverse: inverse,
              type: type,
              isTransient: isTransient,
              isOptional: isOptional,
              deleteRule: deleteRule,
              arrangement: .init(isOrdered: isOrdered, lowerBound: lowerBound, upperBound: upperBound, isMinimum: isMinimum, isMaximum: isMaximum),
              indexInSpotlight: indexInSpotlight)
    }
    
    public func indexInSpotlight(_ value: Bool) -> Self {
        .init(name,
              entity: entityName,
              inverse: inverse,
              type: type,
              isTransient: isTransient,
              isOptional: isOptional,
              deleteRule: deleteRule,
              arrangement: arrangement,
              indexInSpotlight: value)
    }
}

extension Relationship {
    
    func createRelationshipDescription(for entity: NSEntityDescription) -> NSRelationshipDescription {
        let description = NSRelationshipDescription()
        description.name = name
        description.deleteRule = deleteRule.rule
        description.isOrdered = arrangement.isOrdered
        description.minCount = 0
        description.maxCount = type == .toMany ? 0 : 1
        description.destinationEntity = entity
        
        return description
    }
}
