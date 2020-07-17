
import Foundation

// MARK: Entity

public protocol EntityIdentifiable: Equatable, Codable {
    var name: String { get }
}

extension String: EntityIdentifiable {
    public var name: String { self }
}

public struct Entity: Equatable, Codable {
    public typealias ID = UUID
    public typealias Attributes = [Attribute]
    public typealias Relationships = [Relationship]
    
    // MARK: - Properties
    
    public var ID: ID
    public var name: String
    public var isAbstract: Bool
    public var attributes: Attributes
    public var children: [Entity]
    public var relationships: Relationships
    
    
    public var isParentEntity: Bool { children.count > 0 }
    
    // MARK: - Lifecycle
    
    public init(_ name: String, isAbstract: Bool = false, @AttributeBuilder _ builder: () -> Attributes) {
        self.ID = .init()
        self.name = name
        self.isAbstract = isAbstract
        self.attributes = builder()
        self.relationships = []
        self.children = []
    }
    
    public init(_ name: String, isAbstract: Bool = false, @AttributeBuilder _ builder: () -> Attributes, @EntityBuilder children: () -> [Entity]) {
        self.ID = .init()
        self.name = name
        self.isAbstract = isAbstract
        self.attributes = builder()
        self.children = children()
        self.relationships = []
    }
    
    public init(_ name: String, isAbstract: Bool = false, @AttributeBuilder _ builder: () -> Attributes, @RelationshipBuilder relationships: () -> Relationships) {
        self.ID = .init()
        self.name = name
        self.isAbstract = isAbstract
        self.attributes = builder()
        self.children = []
        self.relationships = relationships()
    }
    
    public init(_ name: String, isAbstract: Bool = false, @AttributeBuilder _ builder: () -> Attributes, @EntityBuilder children: () -> [Entity], @RelationshipBuilder relationships: () -> Relationships) {
        self.ID = .init()
        self.name = name
        self.isAbstract = isAbstract
        self.attributes = builder()
        self.children = children()
        self.relationships = relationships()
    }
    
    // MARK: - Methods
}

// MARK: - Attribute

public struct Attribute: Equatable, Codable {
    public enum AttributeType: Int, Codable {
        case string, uuid, int16, int32, int64, decimal, double, float, boolean, date, data, uri
    }
    
    // MARK: - Properties
    
    public var name: String
    public var type: AttributeType
    
    // MARK: - Lifecycle
    
    public init(_ name: String, type: AttributeType) {
        self.name = name
        self.type = type
    }
    
    // MARK: - Methods
}
