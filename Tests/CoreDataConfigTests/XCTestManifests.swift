import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PersistenceLayerTests.allTests),
        testCase(EntityTests.allTests),
        testCase(AttributeTests.allTests),
    ]
}
#endif
