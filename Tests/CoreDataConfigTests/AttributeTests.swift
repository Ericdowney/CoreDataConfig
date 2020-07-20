
import XCTest
@testable import CoreDataConfig

final class AttributeTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_shouldCreateAttributeDescriptionWithDefaults() throws {
        let subject = Attribute("TestAttribute", type: .string)
        
        let result = try subject.createAttributeDescription()
        
        XCTAssertEqual(result.name, "TestAttribute")
        XCTAssertEqual(result.attributeType, .stringAttributeType)
        XCTAssertFalse(result.isTransient)
        XCTAssertFalse(result.isOptional)
        XCTAssertEqual(result.renamingIdentifier, "")
        XCTAssertFalse(result.allowsExternalBinaryDataStorage)
        XCTAssertFalse(result.isIndexedBySpotlight)
        XCTAssertNil(result.defaultValue)
        XCTAssertEqual(result.attributeValueClassName, "NSString")
        XCTAssertNil(result.valueTransformerName)
        XCTAssertFalse(result.preservesValueInHistoryOnDeletion)
    }
    
    func test_shouldCreateAttributeDescriptionWithAllPropertiesSet() throws {
        let subject = Attribute("TestAttribute", type: .string)
            .isTransient(false)
            .isOptional(true)
            .allowsExternalBinaryDataStorage(true)
            .isIndexedBySpotlight(true)
            .attributeValueClassName("SomeOtherClassName")
            .valueTransformerName("SomeValueTransformer")
            .preservesValueInHistoryOnDeletion(true)
            .defaultValue("Hello")
            .renamingIdentifier("_TestAttribute")
        
        let result = try subject.createAttributeDescription()
        
        XCTAssertEqual(result.name, "TestAttribute")
        XCTAssertEqual(result.attributeType, .stringAttributeType)
        XCTAssertFalse(result.isTransient)
        XCTAssertTrue(result.isOptional)
        XCTAssertEqual(result.renamingIdentifier, "_TestAttribute")
        XCTAssertTrue(result.allowsExternalBinaryDataStorage)
        XCTAssertTrue(result.isIndexedBySpotlight)
        XCTAssertEqual(result.defaultValue as? String, "Hello")
        XCTAssertEqual(result.attributeValueClassName, "SomeOtherClassName")
        XCTAssertEqual(result.valueTransformerName, "SomeValueTransformer")
        XCTAssertTrue(result.preservesValueInHistoryOnDeletion)
    }
    
    func test_shouldThrowErrorWhenAttributeIsInvalid() throws {
        let subject = Attribute("TestAttribute", type: .string)
            .isTransient(true)
            .isOptional(true)
            .allowsExternalBinaryDataStorage(true)
            .isIndexedBySpotlight(true)
            .attributeValueClassName("SomeOtherClassName")
            .valueTransformerName("SomeValueTransformer")
            .preservesValueInHistoryOnDeletion(true)
            .defaultValue("Hello")
            .renamingIdentifier("_TestAttribute")
        
        XCTAssertThrowsError(try subject.createAttributeDescription())
    }
    
    func test_shouldValidateAttributeProperties() throws {
        let invalidSubject = Attribute("TestAttribute", type: .string)
            .isTransient(true)
            .isIndexedBySpotlight(true)
        let validSubject1 = Attribute("TestAttribute", type: .string)
            .isTransient(false)
            .isIndexedBySpotlight(true)
        let validSubject2 = Attribute("TestAttribute", type: .string)
            .isTransient(true)
            .isIndexedBySpotlight(false)
        let validSubject3 = Attribute("TestAttribute", type: .string)
            .isTransient(false)
            .isIndexedBySpotlight(false)
        
        XCTAssertFalse(invalidSubject.isValid)
        XCTAssertTrue(validSubject1.isValid)
        XCTAssertTrue(validSubject2.isValid)
        XCTAssertTrue(validSubject3.isValid)
    }
    
    // MARK: - Test Registration
    
    static var allTests = [
        ("test_shouldCreateAttributeDescriptionWithDefaults", test_shouldCreateAttributeDescriptionWithDefaults),
        ("test_shouldCreateAttributeDescriptionWithAllPropertiesSet", test_shouldCreateAttributeDescriptionWithAllPropertiesSet),
        ("test_shouldThrowErrorWhenAttributeIsInvalid", test_shouldThrowErrorWhenAttributeIsInvalid),
        ("test_shouldValidateAttributeProperties", test_shouldValidateAttributeProperties),
    ]
}
