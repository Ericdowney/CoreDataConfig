
import Foundation
import CoreData

open class PersistenceLayer<S: Store> {
    
    // MARK: - Properties
    
    public let store: S
    public let persistentContainer: NSPersistentContainer
    
    public var name: String {
        persistentContainer.name
    }
    public var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        persistentContainer.persistentStoreCoordinator
    }
    public var persistentStoreDescriptions: [NSPersistentStoreDescription] {
        persistentContainer.persistentStoreDescriptions
    }
    public var managedObjectModel: NSManagedObjectModel {
        persistentContainer.managedObjectModel
    }
    public var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Lifecycle
    
    public init(store: S) throws {
        self.store = store
        self.persistentContainer = try NSPersistentContainer(name: store.name, managedObjectModel: Self.createManagedObjectModel(from: store))
    }
    
    // MARK: - Methods
    
    open func initialize(_ completion: @escaping (NSPersistentStoreDescription, Error?) -> Void) {
        persistentContainer.loadPersistentStores(completionHandler: completion)
    }
    
    open func newBackgroundContext() -> NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    private static func createManagedObjectModel(from store: S) throws -> NSManagedObjectModel {
        try NSManagedObjectModel(resolveEntities(from: store.model.entities),
                                 forConfigurationName: store.model.configurationName)
    }
    
    private static func resolveEntities(from entities: [Entity<S.Identifier>]) throws -> [NSEntityDescription] {
        let flattendEntities = entities.map { [$0] + $0.children }.reduce([], +)
        let objects: [(Entity<S.Identifier>, NSEntityDescription)] = try entities.compactMap { try $0.createEntityDescriptions() }.reduce([], +).compactMap { description in
            guard let entity = flattendEntities.first(where: { $0.name == description.name }) else { return nil }
            return (entity, description)
        }
        RelationshipUtility.resolveInverseRelationships(for: objects)
        return objects.map { $0.1 }
    }
}

fileprivate extension NSManagedObjectModel {
    
    convenience init(_ entities: [NSEntityDescription], forConfigurationName configName: String) {
        self.init()
        self.entities = entities
        self.setEntities(entities, forConfigurationName: configName)
    }
}
