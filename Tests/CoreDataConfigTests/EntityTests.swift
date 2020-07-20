
import XCTest
@testable import CoreDataConfig

final class EntityTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_shouldCreateEntityDescription() throws {
        let subject = Entity("TestItem") {
            Attribute("name", type: .string)
        }
        
        let result = try subject.createEntityDescriptions()
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].name, "TestItem")
        XCTAssertEqual(result[0].properties.count, 1)
        XCTAssertEqual(result[0].properties[0].name, "name")
        XCTAssertEqual({ result[0].properties[0] as! NSAttributeDescription }().attributeType, NSAttributeType.stringAttributeType)
        XCTAssertFalse(result[0].isAbstract)
        XCTAssertEqual(result[0].managedObjectClassName, "TestItem")
        XCTAssertEqual(result[0].renamingIdentifier, "")
        XCTAssertEqual(result[0].subentities.count, 0)
    }
    
    func test_shouldCreateEntityDescriptionWithSubentities() throws {
        let subject = Entity("TestItem") {
            Attribute("name", type: .string)
        } children: {
            Entity("OtherItem") {
                Attribute("flag", type: .boolean)
            }
        }
        
        let result = try subject.createEntityDescriptions()
        
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].name, "TestItem")
        XCTAssertEqual(result[0].subentities.count, 1)
        XCTAssertEqual(result[1].name, "OtherItem")
        XCTAssertEqual(result[1].properties.count, 2)
        XCTAssertEqual(result[1].properties[0].name, "name")
        XCTAssertEqual(result[1].properties[1].name, "flag")
        XCTAssertEqual({ result[1].properties[0] as! NSAttributeDescription }().attributeType, NSAttributeType.stringAttributeType)
        XCTAssertEqual({ result[1].properties[1] as! NSAttributeDescription }().attributeType, NSAttributeType.booleanAttributeType)
        XCTAssertFalse(result[1].isAbstract)
        XCTAssertEqual(result[1].managedObjectClassName, "OtherItem")
        XCTAssertEqual(result[1].renamingIdentifier, "")
        XCTAssertEqual(result[1].subentities.count, 0)
    }
    
    // MARK: - Test Registration
    
    static var allTests = [
        ("test_shouldCreateEntityDescription", test_shouldCreateEntityDescription),
        ("test_shouldCreateEntityDescriptionWithSubentities", test_shouldCreateEntityDescriptionWithSubentities),
    ]
}
