
import Foundation
import CoreData

public protocol EntityWrapper {
    associatedtype Identifier: EntityIdentifiable
    
    var entity: Entity<Identifier> { get }
}

public struct AnyEntityWrapper<Identifier: EntityIdentifiable>: EntityWrapper {
    
    public var entity: Entity<Identifier>
    
    public init<Wrapper: EntityWrapper>(_ wrapper: Wrapper) where Wrapper.Identifier == Identifier {
        self.entity = wrapper.entity
    }
}

extension EntityWrapper {
    
    public func eraseToAny() -> AnyEntityWrapper<Identifier> {
        .init(self)
    }
}

public struct Entity<Identifier: EntityIdentifiable>: Equatable, Codable {
    
    public typealias Children = [Entity<Identifier>]
    
    // MARK: - Properties
    
    public var ID: Identifier
    public var isAbstract: Bool = false
    public var attributes: [Attribute]
    public var children: Children
    public var relationships: [Relationship<Identifier>]
    public var managedObjectClassName: String = ""
    public var constraints: [String] = []
    public var renamingIdentifier: String = ""
    
    public var name: String { ID.name }
    public var isParentEntity: Bool { children.count > 0 }
    
    // MARK: - Lifecycle
    
    public init(_ id: Identifier, @AttributeBuilder attributes: () -> [Attribute]) {
        self.ID = id
        self.attributes = attributes()
        self.relationships = []
        self.children = []
        self.managedObjectClassName = name
    }
    
    public init(_ id: Identifier, @AttributeBuilder attributes: () -> [Attribute], @EntityBuilder children: () -> Children) {
        self.ID = id
        self.attributes = attributes()
        self.children = children()
        self.relationships = []
        self.managedObjectClassName = name
    }
    
    public init(_ id: Identifier, @AttributeBuilder attributes: () -> [Attribute], @RelationshipBuilder relationships: () -> [Relationship<Identifier>]) {
        self.ID = id
        self.attributes = attributes()
        self.children = []
        self.relationships = relationships()
        self.managedObjectClassName = name
    }
    
    public init(_ id: Identifier, @AttributeBuilder attributes: () -> [Attribute], @EntityBuilder children: () -> Children, @RelationshipBuilder relationships: () -> [Relationship<Identifier>]) {
        self.ID = id
        self.attributes = attributes()
        self.children = children()
        self.relationships = relationships()
        self.managedObjectClassName = name
    }
    
    init(_ id: Identifier,
         _ isAbstract: Bool,
         _ attributes: [Attribute],
         _ children: Children,
         _ relationships: [Relationship<Identifier>],
         _ managedObjectClassName: String,
         _ constraints: [String],
         _ renamingIdentifier: String) {
        self.ID = id
        self.isAbstract = isAbstract
        self.attributes = attributes
        self.children = children
        self.relationships = relationships
        self.managedObjectClassName = managedObjectClassName
        self.constraints = constraints
        self.renamingIdentifier = renamingIdentifier
    }
    
    // MARK: - Methods
    
    public func isAbstract(_ value: Bool) -> Self {
        .init(self.ID,
              value,
              attributes,
              children,
              relationships,
              managedObjectClassName,
              constraints,
              renamingIdentifier)
    }
    
    public func managedObjectClassName(_ value: String) -> Self {
        .init(self.ID,
              isAbstract,
              attributes,
              children,
              relationships,
              value,
              constraints,
              renamingIdentifier)
    }
    
    public func constraints(_ value: String) -> Self {
        .init(self.ID,
              isAbstract,
              attributes,
              children,
              relationships,
              managedObjectClassName,
              value.components(separatedBy: ","),
              renamingIdentifier)
    }
    
    public func constraints(_ value: [String]) -> Self {
        .init(self.ID,
              isAbstract,
              attributes,
              children,
              relationships,
              managedObjectClassName,
              value,
              renamingIdentifier)
    }
    
    public func renamingIdentifier(_ value: String) -> Self {
        .init(self.ID,
              isAbstract,
              attributes,
              children,
              relationships,
              managedObjectClassName,
              constraints,
              value)
    }
}

extension Entity: EntityWrapper {
    
    public var entity: Entity<Identifier> { self }
}

extension Entity {
    
    func createEntityDescriptions() throws -> [NSEntityDescription] {
        try createEntityDescription(from: self)
    }
    
    private func createEntityDescription(from entity: Entity) throws -> [NSEntityDescription] {
        let description = NSEntityDescription()
        description.name = entity.ID.name
        description.properties = try entity.attributes.compactMap { try $0.createAttributeDescription() }
        description.isAbstract = entity.isAbstract
        description.managedObjectClassName = entity.managedObjectClassName
        description.renamingIdentifier = entity.renamingIdentifier
        
        let relationshipDescriptions = entity.relationships.map { $0.createRelationshipDescription(for: description) }
        description.properties += relationshipDescriptions
        
        let subentityDescriptions = try entity.children.map(createEntityDescription(from:)).reduce([], +)
        description.subentities = subentityDescriptions
        
        return [description] + subentityDescriptions
    }
}
