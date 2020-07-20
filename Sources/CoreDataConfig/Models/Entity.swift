
import Foundation
import CoreData

// MARK: Entity

public protocol EntityWrapper {
    
    var entity: Entity { get }
}

public struct Entity: Equatable, Codable {
    public enum CodeGeneration: Int, Codable {
        case manual, `class`, `extension`
    }
    
    public typealias Identifier = UUID
    public typealias Attributes = [Attribute]
    public typealias Children = [Entity]
    public typealias Relationships = [Relationship]
    
    // MARK: - Properties
    
    public var ID: Identifier
    public var name: String
    public var isAbstract: Bool = false
    public var attributes: Attributes
    public var children: Children
    public var relationships: Relationships
    public var managedObjectClassName: String = ""
    public var module: String = ""
    public var codeGeneration: CodeGeneration = .class
    public var constraints: [String] = []
    public var renamingIdentifier: String = ""
    
    public var isParentEntity: Bool { children.count > 0 }
    
    // MARK: - Lifecycle
    
    public init(_ name: String, @AttributeBuilder _ builder: () -> Attributes) {
        self.ID = .init()
        self.name = name
        self.attributes = builder()
        self.relationships = []
        self.children = []
        self.managedObjectClassName = name
    }
    
    public init(_ name: String, @AttributeBuilder _ builder: () -> Attributes, @EntityBuilder children: () -> Children) {
        self.ID = .init()
        self.name = name
        self.attributes = builder()
        self.children = children()
        self.relationships = []
        self.managedObjectClassName = name
    }
    
    public init(_ name: String, @AttributeBuilder _ builder: () -> Attributes, @RelationshipBuilder relationships: () -> Relationships) {
        self.ID = .init()
        self.name = name
        self.attributes = builder()
        self.children = []
        self.relationships = relationships()
        self.managedObjectClassName = name
    }
    
    public init(_ name: String, @AttributeBuilder _ builder: () -> Attributes, @EntityBuilder children: () -> Children, @RelationshipBuilder relationships: () -> Relationships) {
        self.ID = .init()
        self.name = name
        self.attributes = builder()
        self.children = children()
        self.relationships = relationships()
        self.managedObjectClassName = name
    }
    
    init(_ ID: Identifier,
         _ name: String,
         _ isAbstract: Bool,
         _ attributes: Attributes,
         _ children: Children,
         _ relationships: Relationships,
         _ managedObjectClassName: String,
         _ module: String,
         _ codeGeneration: CodeGeneration,
         _ constraints: [String],
         _ renamingIdentifier: String) {
        self.ID = ID
        self.name = name
        self.isAbstract = isAbstract
        self.attributes = attributes
        self.children = children
        self.relationships = relationships
        self.managedObjectClassName = managedObjectClassName
        self.module = module
        self.codeGeneration = codeGeneration
        self.constraints = constraints
        self.renamingIdentifier = renamingIdentifier
    }
    
    // MARK: - Methods
    
    public func isAbstract(_ value: Bool) -> Self {
        .init(ID,
              name,
              value,
              attributes,
              children,
              relationships,
              managedObjectClassName,
              module,
              codeGeneration,
              constraints,
              renamingIdentifier)
    }
    
    public func managedObjectClassName(_ value: String) -> Self {
        .init(ID,
              name,
              isAbstract,
              attributes,
              children,
              relationships,
              value,
              module,
              codeGeneration,
              constraints,
              renamingIdentifier)
    }
    
    public func module(_ value: String) -> Self {
        .init(ID,
              name,
              isAbstract,
              attributes,
              children,
              relationships,
              managedObjectClassName,
              value,
              codeGeneration,
              constraints,
              renamingIdentifier)
    }
    
    public func codeGeneration(_ value: CodeGeneration) -> Self {
        .init(ID,
              name,
              isAbstract,
              attributes,
              children,
              relationships,
              managedObjectClassName,
              module,
              value,
              constraints,
              renamingIdentifier)
    }
    
    public func constraints(_ value: String) -> Self {
        .init(ID,
              name,
              isAbstract,
              attributes,
              children,
              relationships,
              managedObjectClassName,
              module,
              codeGeneration,
              value.components(separatedBy: ","),
              renamingIdentifier)
    }
    
    public func constraints(_ value: [String]) -> Self {
        .init(ID,
              name,
              isAbstract,
              attributes,
              children,
              relationships,
              managedObjectClassName,
              module,
              codeGeneration,
              value,
              renamingIdentifier)
    }
    
    public func renamingIdentifier(_ value: String) -> Self {
        .init(ID,
              name,
              isAbstract,
              attributes,
              children,
              relationships,
              managedObjectClassName,
              module,
              codeGeneration,
              constraints,
              value)
    }
}

extension Entity: EntityWrapper {
    
    public var entity: Entity { self }
}

extension Entity {
    
    func createEntityDescriptions() throws -> [NSEntityDescription] {
        try createEntityDescription(from: self)
    }
    
    private func createEntityDescription(from entity: Entity) throws -> [NSEntityDescription] {
        let description = NSEntityDescription()
        description.name = entity.name
        description.properties = try entity.attributes.compactMap { try $0.createAttributeDescription(entity) }
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
