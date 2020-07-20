import XCTest

import CoreDataConfigTests

var tests = [XCTestCaseEntry]()
tests += PersistenceLayerTests.allTests()
tests += EntityTests.allTests()
tests += AttributeTests.allTests()
XCTMain(tests)
