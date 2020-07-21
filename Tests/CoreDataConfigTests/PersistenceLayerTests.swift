
import XCTest
import CoreData
@testable import CoreDataConfig

final class PersistenceLayerTests: XCTestCase {
    
    var subject: PersistenceLayer<ComicBookStore>!
    
    override func setUp() {
        super.setUp()
        
        do {
            subject = try PersistenceLayer(store: ComicBookStore())
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Tests
    
    func test_shouldCreateManagedObjectModel() throws {
        let model = subject.managedObjectModel
        
        XCTAssertGreaterThanOrEqual(model.configurations.count, 1)
        XCTAssertEqual(model.configurations[0], "Default")
        XCTAssertNotNil(model.entitiesByName["BaseObject"])
        XCTAssertNotNil(model.entitiesByName["Publisher"])
        XCTAssertNotNil(model.entitiesByName["Series"])
        XCTAssertNotNil(model.entitiesByName["Event"])
        XCTAssertNotNil(model.entitiesByName["Tag"])
        XCTAssertNotNil(model.entitiesByName["Box"])
        XCTAssertNotNil(model.entitiesByName["ComicBook"])
    }
    
    func test_shouldCreateManagedObjectModelWithSubentities() throws {
        let model = subject.managedObjectModel
        
        let baseObject = model.entitiesByName["BaseObject"]
        XCTAssertNotNil(baseObject)
        XCTAssertNotNil(baseObject?.subentitiesByName["Publisher"])
        XCTAssertNotNil(baseObject?.subentitiesByName["Series"])
        XCTAssertNotNil(baseObject?.subentitiesByName["Event"])
        XCTAssertNotNil(baseObject?.subentitiesByName["Tag"])
        XCTAssertNotNil(baseObject?.subentitiesByName["Box"])
        XCTAssertNotNil(baseObject?.subentitiesByName["ComicBook"])
    }
    
    func test_shouldCreateManagedObjectModelWithAllProperties() throws {
        let model = subject.managedObjectModel
        
        let baseObject = model.entitiesByName["BaseObject"]!
        let objectPublisher = model.entitiesByName["Publisher"]!
        let objectSeries = model.entitiesByName["Series"]!
        let objectEvent = model.entitiesByName["Event"]!
        let objectTag = model.entitiesByName["Tag"]!
        let objectBox = model.entitiesByName["Box"]!
        let objectComicBook = model.entitiesByName["ComicBook"]!
        
        XCTAssertTrue(baseObject.isAbstract)
        XCTAssertEqual(baseObject.managedObjectClassName, "BaseObject")
        XCTAssertEqual(baseObject.renamingIdentifier, "_BaseObject")
        
        XCTAssertFalse(objectPublisher.isAbstract)
        XCTAssertEqual(objectPublisher.managedObjectClassName, "Publisher")
        XCTAssertEqual(objectPublisher.renamingIdentifier, "_Publisher")
        
        XCTAssertFalse(objectSeries.isAbstract)
        XCTAssertEqual(objectSeries.managedObjectClassName, "Series")
        XCTAssertEqual(objectSeries.renamingIdentifier, "_Series")
        
        XCTAssertFalse(objectEvent.isAbstract)
        XCTAssertEqual(objectEvent.managedObjectClassName, "Event")
        XCTAssertEqual(objectEvent.renamingIdentifier, "_Event")
        
        XCTAssertFalse(objectTag.isAbstract)
        XCTAssertEqual(objectTag.managedObjectClassName, "Tag")
        XCTAssertEqual(objectTag.renamingIdentifier, "_Tag")
        
        XCTAssertFalse(objectBox.isAbstract)
        XCTAssertEqual(objectBox.managedObjectClassName, "Box")
        XCTAssertEqual(objectBox.renamingIdentifier, "_Box")
        
        XCTAssertFalse(objectComicBook.isAbstract)
        XCTAssertEqual(objectComicBook.managedObjectClassName, "ComicBook")
        XCTAssertEqual(objectComicBook.renamingIdentifier, "_ComicBook")
    }
    
    func test_shouldCreateManagedObjectModelWithAllAttributes() throws {
        let model = subject.managedObjectModel
        
        let baseObject = model.entitiesByName["BaseObject"]!
        let objectPublisher = model.entitiesByName["Publisher"]!
        let objectSeries = model.entitiesByName["Series"]!
        let objectEvent = model.entitiesByName["Event"]!
        let objectTag = model.entitiesByName["Tag"]!
        let objectBox = model.entitiesByName["Box"]!
        let objectComicBook = model.entitiesByName["ComicBook"]!
        
        assertBaseObjectProperties(baseObject.properties)
        assertPublisherProperties(objectPublisher.properties)
        assertSeriesProperties(objectSeries.properties)
        assertEventProperties(objectEvent.properties)
        assertTagProperties(objectTag.properties)
        assertBoxProperties(objectBox.properties)
        assertComicBookProperties(objectComicBook.properties)
    }
    
    func test_shouldCreateManagedObjectModelWithAllRelationships() throws {
        let model = subject.managedObjectModel
        
        let baseObject = model.entitiesByName["BaseObject"]!
        let objectPublisher = model.entitiesByName["Publisher"]!
        let objectSeries = model.entitiesByName["Series"]!
        let objectEvent = model.entitiesByName["Event"]!
        let objectTag = model.entitiesByName["Tag"]!
        let objectBox = model.entitiesByName["Box"]!
        let objectComicBook = model.entitiesByName["ComicBook"]!
        
        XCTAssertEqual(baseObject.relationshipsByName.count, 0)
        
        XCTAssertEqual(objectPublisher.relationshipsByName.count, 2)
        XCTAssertEqual(objectPublisher.relationshipsByName["series"]?.deleteRule, .cascadeDeleteRule)
        XCTAssertEqual(objectPublisher.relationshipsByName["series"]?.isOrdered, false)
        XCTAssertEqual(objectPublisher.relationshipsByName["series"]?.minCount, 0)
        XCTAssertEqual(objectPublisher.relationshipsByName["series"]?.maxCount, 0)
        XCTAssertEqual(objectPublisher.relationshipsByName["series"]?.isToMany, true)
        XCTAssertEqual(objectPublisher.relationshipsByName["series"]?.destinationEntity, objectPublisher)
        XCTAssertEqual(objectPublisher.relationshipsByName["series"]?.inverseRelationship?.destinationEntity, objectSeries)
        
        XCTAssertEqual(objectPublisher.relationshipsByName["events"]?.deleteRule, .cascadeDeleteRule)
        XCTAssertEqual(objectPublisher.relationshipsByName["events"]?.isOrdered, false)
        XCTAssertEqual(objectPublisher.relationshipsByName["events"]?.minCount, 0)
        XCTAssertEqual(objectPublisher.relationshipsByName["events"]?.maxCount, 0)
        XCTAssertEqual(objectPublisher.relationshipsByName["events"]?.isToMany, true)
        XCTAssertEqual(objectPublisher.relationshipsByName["events"]?.destinationEntity, objectPublisher)
        XCTAssertEqual(objectPublisher.relationshipsByName["events"]?.inverseRelationship?.destinationEntity, objectEvent)
        
        XCTAssertEqual(objectSeries.relationshipsByName.count, 2)
        XCTAssertEqual(objectSeries.relationshipsByName["publisher"]?.deleteRule, .nullifyDeleteRule)
        XCTAssertEqual(objectSeries.relationshipsByName["publisher"]?.isOrdered, false)
        XCTAssertEqual(objectSeries.relationshipsByName["publisher"]?.minCount, 0)
        XCTAssertEqual(objectSeries.relationshipsByName["publisher"]?.maxCount, 1)
        XCTAssertEqual(objectSeries.relationshipsByName["publisher"]?.isToMany, false)
        XCTAssertEqual(objectSeries.relationshipsByName["publisher"]?.destinationEntity, objectSeries)
        XCTAssertEqual(objectSeries.relationshipsByName["publisher"]?.inverseRelationship?.destinationEntity, objectPublisher)
        
        XCTAssertEqual(objectSeries.relationshipsByName["comicBooks"]?.deleteRule, .cascadeDeleteRule)
        XCTAssertEqual(objectSeries.relationshipsByName["comicBooks"]?.isOrdered, false)
        XCTAssertEqual(objectSeries.relationshipsByName["comicBooks"]?.minCount, 0)
        XCTAssertEqual(objectSeries.relationshipsByName["comicBooks"]?.maxCount, 0)
        XCTAssertEqual(objectSeries.relationshipsByName["comicBooks"]?.isToMany, true)
        XCTAssertEqual(objectSeries.relationshipsByName["comicBooks"]?.destinationEntity, objectSeries)
        XCTAssertEqual(objectSeries.relationshipsByName["comicBooks"]?.inverseRelationship?.destinationEntity, objectComicBook)
        
        XCTAssertEqual(objectEvent.relationshipsByName.count, 2)
        XCTAssertEqual(objectEvent.relationshipsByName["publisher"]?.deleteRule, .nullifyDeleteRule)
        XCTAssertEqual(objectEvent.relationshipsByName["publisher"]?.isOrdered, false)
        XCTAssertEqual(objectEvent.relationshipsByName["publisher"]?.minCount, 0)
        XCTAssertEqual(objectEvent.relationshipsByName["publisher"]?.maxCount, 1)
        XCTAssertEqual(objectEvent.relationshipsByName["publisher"]?.isToMany, false)
        XCTAssertEqual(objectEvent.relationshipsByName["publisher"]?.destinationEntity, objectEvent)
        XCTAssertEqual(objectEvent.relationshipsByName["publisher"]?.inverseRelationship?.destinationEntity, objectPublisher)
        
        XCTAssertEqual(objectEvent.relationshipsByName["comicBooks"]?.deleteRule, .nullifyDeleteRule)
        XCTAssertEqual(objectEvent.relationshipsByName["comicBooks"]?.isOrdered, true)
        XCTAssertEqual(objectEvent.relationshipsByName["comicBooks"]?.minCount, 0)
        XCTAssertEqual(objectEvent.relationshipsByName["comicBooks"]?.maxCount, 0)
        XCTAssertEqual(objectEvent.relationshipsByName["comicBooks"]?.isToMany, true)
        XCTAssertEqual(objectEvent.relationshipsByName["comicBooks"]?.destinationEntity, objectEvent)
        XCTAssertEqual(objectEvent.relationshipsByName["comicBooks"]?.inverseRelationship?.destinationEntity, objectComicBook)
        
        XCTAssertEqual(objectTag.relationshipsByName.count, 1)
        XCTAssertEqual(objectTag.relationshipsByName["comicBooks"]?.deleteRule, .nullifyDeleteRule)
        XCTAssertEqual(objectTag.relationshipsByName["comicBooks"]?.isOrdered, false)
        XCTAssertEqual(objectTag.relationshipsByName["comicBooks"]?.minCount, 0)
        XCTAssertEqual(objectTag.relationshipsByName["comicBooks"]?.maxCount, 0)
        XCTAssertEqual(objectTag.relationshipsByName["comicBooks"]?.isToMany, true)
        XCTAssertEqual(objectTag.relationshipsByName["comicBooks"]?.destinationEntity, objectTag)
        XCTAssertEqual(objectTag.relationshipsByName["comicBooks"]?.inverseRelationship?.destinationEntity, objectComicBook)
        
        XCTAssertEqual(objectBox.relationshipsByName.count, 1)
        XCTAssertEqual(objectBox.relationshipsByName["comicBooks"]?.deleteRule, .nullifyDeleteRule)
        XCTAssertEqual(objectBox.relationshipsByName["comicBooks"]?.isOrdered, true)
        XCTAssertEqual(objectBox.relationshipsByName["comicBooks"]?.minCount, 0)
        XCTAssertEqual(objectBox.relationshipsByName["comicBooks"]?.maxCount, 0)
        XCTAssertEqual(objectBox.relationshipsByName["comicBooks"]?.isToMany, true)
        XCTAssertEqual(objectBox.relationshipsByName["comicBooks"]?.destinationEntity, objectBox)
        XCTAssertEqual(objectBox.relationshipsByName["comicBooks"]?.inverseRelationship?.destinationEntity, objectComicBook)
        
        XCTAssertEqual(objectComicBook.relationshipsByName.count, 4)
        XCTAssertEqual(objectComicBook.relationshipsByName["box"]?.deleteRule, .nullifyDeleteRule)
        XCTAssertEqual(objectComicBook.relationshipsByName["box"]?.isOrdered, true)
        XCTAssertEqual(objectComicBook.relationshipsByName["box"]?.minCount, 0)
        XCTAssertEqual(objectComicBook.relationshipsByName["box"]?.maxCount, 1)
        XCTAssertEqual(objectComicBook.relationshipsByName["box"]?.isToMany, false)
        XCTAssertEqual(objectComicBook.relationshipsByName["box"]?.destinationEntity, objectComicBook)
        XCTAssertEqual(objectComicBook.relationshipsByName["box"]?.inverseRelationship?.destinationEntity, objectBox)
        
        XCTAssertEqual(objectComicBook.relationshipsByName["series"]?.deleteRule, .nullifyDeleteRule)
        XCTAssertEqual(objectComicBook.relationshipsByName["series"]?.isOrdered, false)
        XCTAssertEqual(objectComicBook.relationshipsByName["series"]?.minCount, 0)
        XCTAssertEqual(objectComicBook.relationshipsByName["series"]?.maxCount, 1)
        XCTAssertEqual(objectComicBook.relationshipsByName["series"]?.isToMany, false)
        XCTAssertEqual(objectComicBook.relationshipsByName["series"]?.destinationEntity, objectComicBook)
        XCTAssertEqual(objectComicBook.relationshipsByName["series"]?.inverseRelationship?.destinationEntity, objectSeries)
        
        XCTAssertEqual(objectComicBook.relationshipsByName["tags"]?.deleteRule, .nullifyDeleteRule)
        XCTAssertEqual(objectComicBook.relationshipsByName["tags"]?.isOrdered, false)
        XCTAssertEqual(objectComicBook.relationshipsByName["tags"]?.minCount, 0)
        XCTAssertEqual(objectComicBook.relationshipsByName["tags"]?.maxCount, 0)
        XCTAssertEqual(objectComicBook.relationshipsByName["tags"]?.isToMany, true)
        XCTAssertEqual(objectComicBook.relationshipsByName["tags"]?.destinationEntity, objectComicBook)
        XCTAssertEqual(objectComicBook.relationshipsByName["tags"]?.inverseRelationship?.destinationEntity, objectTag)
        
        XCTAssertEqual(objectComicBook.relationshipsByName["event"]?.deleteRule, .nullifyDeleteRule)
        XCTAssertEqual(objectComicBook.relationshipsByName["event"]?.isOrdered, false)
        XCTAssertEqual(objectComicBook.relationshipsByName["event"]?.minCount, 0)
        XCTAssertEqual(objectComicBook.relationshipsByName["event"]?.maxCount, 1)
        XCTAssertEqual(objectComicBook.relationshipsByName["event"]?.isToMany, false)
        XCTAssertEqual(objectComicBook.relationshipsByName["event"]?.destinationEntity, objectComicBook)
        XCTAssertEqual(objectComicBook.relationshipsByName["event"]?.inverseRelationship?.destinationEntity, objectEvent)
        
    }
    
    private func assertBaseObjectProperties(_ attributes: [NSPropertyDescription], _ file: StaticString = #filePath, _ line: UInt = #line) {
        let idAttribute = attributes.first { $0.name == "id" } as! NSAttributeDescription
        
        XCTAssertEqual(idAttribute.isOptional, false, file: file, line: line)
        
        let createdAtAttribute = attributes.first { $0.name == "createdAt" } as! NSAttributeDescription
        XCTAssertEqual(createdAtAttribute.isOptional, false, file: file, line: line)
        
        let modifiedAtAttribute = attributes.first { $0.name == "modifiedAt" } as! NSAttributeDescription
        XCTAssertEqual(modifiedAtAttribute.isOptional, false, file: file, line: line)
    }
    
    private func assertPublisherProperties(_ attributes: [NSPropertyDescription], _ file: StaticString = #filePath, _ line: UInt = #line) {
        let nameAttribute = attributes.first { $0.name == "name" } as! NSAttributeDescription
        XCTAssertEqual(nameAttribute.attributeType, .stringAttributeType, file: file, line: line)
        XCTAssertEqual(nameAttribute.isOptional, false, file: file, line: line)
    }
    
    private func assertSeriesProperties(_ attributes: [NSPropertyDescription], _ file: StaticString = #filePath, _ line: UInt = #line) {
        let nameAttribute = attributes.first { $0.name == "name" } as! NSAttributeDescription
        XCTAssertEqual(nameAttribute.attributeType, .stringAttributeType, file: file, line: line)
        XCTAssertEqual(nameAttribute.isOptional, false, file: file, line: line)
    }
    
    private func assertEventProperties(_ attributes: [NSPropertyDescription], _ file: StaticString = #filePath, _ line: UInt = #line) {
        let nameAttribute = attributes.first { $0.name == "name" } as! NSAttributeDescription
        XCTAssertEqual(nameAttribute.attributeType, .stringAttributeType, file: file, line: line)
        XCTAssertEqual(nameAttribute.isOptional, false, file: file, line: line)
    }
    
    private func assertTagProperties(_ attributes: [NSPropertyDescription], _ file: StaticString = #filePath, _ line: UInt = #line) {
        let nameAttribute = attributes.first { $0.name == "name" } as! NSAttributeDescription
        XCTAssertEqual(nameAttribute.attributeType, .stringAttributeType, file: file, line: line)
        XCTAssertEqual(nameAttribute.isOptional, false, file: file, line: line)
    }
    
    private func assertBoxProperties(_ attributes: [NSPropertyDescription], _ file: StaticString = #filePath, _ line: UInt = #line) {
        let nameAttribute = attributes.first { $0.name == "name" } as! NSAttributeDescription
        XCTAssertEqual(nameAttribute.attributeType, .stringAttributeType, file: file, line: line)
        XCTAssertEqual(nameAttribute.isOptional, false, file: file, line: line)
    }
    
    private func assertComicBookProperties(_ attributes: [NSPropertyDescription], _ file: StaticString = #filePath, _ line: UInt = #line) {
        let upcAttribute = attributes.first { $0.name == "upc" } as! NSAttributeDescription
        XCTAssertEqual(upcAttribute.attributeType, .stringAttributeType, file: file, line: line)
        
        let priceAttribute = attributes.first { $0.name == "price" } as! NSAttributeDescription
        XCTAssertEqual(priceAttribute.attributeType, .doubleAttributeType, file: file, line: line)
        
        let issueNumAttribute = attributes.first { $0.name == "issueNum" } as! NSAttributeDescription
        XCTAssertEqual(issueNumAttribute.attributeType, .integer16AttributeType, file: file, line: line)
        
        let volumeNumAttribute = attributes.first { $0.name == "volumeNum" } as! NSAttributeDescription
        XCTAssertEqual(volumeNumAttribute.attributeType, .integer16AttributeType, file: file, line: line)
        
        let releaseDateAttribute = attributes.first { $0.name == "releaseDate" } as! NSAttributeDescription
        XCTAssertEqual(releaseDateAttribute.attributeType, .dateAttributeType, file: file, line: line)
        
        let coverImageDataAttribute = attributes.first { $0.name == "coverImageData" } as! NSAttributeDescription
        XCTAssertEqual(coverImageDataAttribute.attributeType, .binaryDataAttributeType, file: file, line: line)
    }
    
    // MARK: - Test Registration
    
    static var allTests = [
        ("test_shouldCreateManagedObjectModel", test_shouldCreateManagedObjectModel),
        ("test_shouldCreateManagedObjectModelWithSubentities", test_shouldCreateManagedObjectModelWithSubentities),
        ("test_shouldCreateManagedObjectModelWithAllProperties", test_shouldCreateManagedObjectModelWithAllProperties),
        ("test_shouldCreateManagedObjectModelWithAllAttributes", test_shouldCreateManagedObjectModelWithAllAttributes),
        ("test_shouldCreateManagedObjectModelWithAllRelationships", test_shouldCreateManagedObjectModelWithAllRelationships)
    ]
}
