
import Foundation
import CoreData

final class RelationshipUtility {

    // MARK: - Properties

    // MARK: - Lifecycle

    // MARK: - Methods
    
    class func resolveInverseRelationships(for objects: [(entity: Entity, description: NSEntityDescription)]) {
        objects.forEach { object in
            let relationshipPairs: [(Relationship, NSRelationshipDescription)] = object.description.relationshipsByName.compactMap { item in
                guard let relationship = object.entity.relationships.first(where: { $0.name == item.value.name }) else { return nil }
                return (relationship, item.value)
            }
            relationshipPairs.forEach { pair in
                if let inverseRelationship = findRelationship(byDestinationName: pair.0.name, inverseName: pair.0.inverse, onEntity: pair.0.entityName, in: objects.map { $0.description }) {
                    inverseRelationship.inverseRelationship = pair.1
                    pair.1.inverseRelationship = inverseRelationship
                }
            }
        }
    }
    
    private class func findRelationship(byDestinationName: String, inverseName: String, onEntity entityName: String, in entities: [NSEntityDescription]) -> NSRelationshipDescription? {
        for entity in entities {
            if entity.name == entityName {
                return entity.relationshipsByName.first { (key: String, value: NSRelationshipDescription) in
                    key == inverseName && value.destinationEntity?.name == entityName
                }?.value
            }
        }
        return nil
    }
}
