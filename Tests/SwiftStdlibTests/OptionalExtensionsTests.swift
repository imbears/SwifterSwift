// OptionalExtensionsTests.swift - Copyright 2025 SwifterSwift

@testable import SwifterSwift
import XCTest

private enum OptionalTestError: Error {
    case optionalIsNil
}

final class OptionalExtensionsTests: XCTestCase {
    func testUnwrappedOrDefault() {
        var str: String?
        XCTAssertEqual(str.unwrapped(or: "swift"), "swift")

        str = "swifterswift"
        XCTAssertEqual(str.unwrapped(or: "swift"), "swifterswift")
    }

    func testUnwrappedOrError() {
        let null: String? = nil
        try XCTAssertThrowsError(null.unwrapped(or: OptionalTestError.optionalIsNil))

        let some: String? = "I exist"
        try XCTAssertNoThrow(some.unwrapped(or: OptionalTestError.optionalIsNil))
    }

    func testRunBlock() {
        var str: String?
        var didRun = false
        str.run { _ in
            didRun = true
        }
        XCTAssertFalse(didRun)
        str = "swift"
        str.run { item in
            didRun = true
            XCTAssert(didRun)
            XCTAssertEqual(item, "swift")
        }
    }

    func testOptionalAssignment() {
        let parameter1: String? = nil
        let parameter2: String? = "foo"

        let key1 = "key1"
        let key2 = "key2"

        var parameters = [String: String]()

        parameters[key1] ??= parameter1
        parameters[key2] ??= parameter2

        XCTAssertNil(parameters[key1])
        XCTAssertEqual(parameters[key1], parameter1)
        XCTAssertEqual(parameters[key2], parameter2)
    }

    func testConditionalAssignment() {
        var text1: String?
        text1 ?= "newText1"
        XCTAssertEqual(text1, "newText1")

        var text2: String? = "text2"
        text2 ?= "newText2"
        XCTAssertEqual(text2, "text2")

        var text3: String?
        text3 ?= nil
        XCTAssertNil(text3)

        var text4: String? = "text4"
        text4 ?= nil
        XCTAssertEqual(text4, "text4")
    }

    func testIsNilOrEmpty() {
        let nilArray: [String]? = nil
        XCTAssert(nilArray.isNilOrEmpty)

        let emptyArray: [String]? = []
        XCTAssert(emptyArray.isNilOrEmpty)

        let intArray: [Int]? = [1]
        XCTAssertFalse(intArray.isNilOrEmpty)

        let optionalArray: [Int]? = [1]
        XCTAssertFalse(optionalArray.isNilOrEmpty)

        let nilString: String? = nil
        XCTAssert(nilString.isNilOrEmpty)

        let emptyString: String? = ""
        XCTAssert(emptyString.isNilOrEmpty)

        let string: String? = "hello World!"
        XCTAssertFalse(string.isNilOrEmpty)
    }

    func testNonEmpty() {
        let nilCollection: [Int]? = nil
        XCTAssertNil(nilCollection.nonEmpty)

        let emptyCollection: [Int]? = []
        XCTAssertNil(emptyCollection.nonEmpty)

        let collection: [Int]? = [1, 2, 3]
        XCTAssertNotNil(collection.nonEmpty)
        XCTAssertEqual(collection.nonEmpty!, [1, 2, 3])
    }

    func testEqualsRawValue() {
        let summerString = "summer"
        let summerStringOptional: String? = "summer"
        let nilString: String? = nil

        let summer = Season.summer
        XCTAssert(summer == summerString)
        XCTAssert(summerString == summer)
        XCTAssert(summer == summerStringOptional)
        XCTAssert(summerStringOptional == summer)
        XCTAssertFalse(summer == nilString)
        XCTAssertFalse(nilString == summer)

        let summerOptional: Season? = Season.summer
        XCTAssert(summerOptional == summerString)
        XCTAssert(summerString == summerOptional)
        XCTAssert(summerOptional == summerStringOptional)
        XCTAssert(summerStringOptional == summerOptional)
        XCTAssertFalse(summerOptional == nilString)
        XCTAssertFalse(nilString == summerOptional)

        let nilSummer: Season? = nil
        XCTAssertFalse(nilSummer == summerString)
        XCTAssertFalse(summerString == nilSummer)
        XCTAssertFalse(nilSummer == summerStringOptional)
        XCTAssertFalse(summerStringOptional == nilSummer)
        XCTAssert(nilSummer == nilString)
        XCTAssert(nilString == nilSummer)
    }

    func testNotEqualsRawValue() {
        let summerString = "summer"
        let summerStringOptional: String? = "summer"
        let nilString: String? = nil

        let summer = Season.summer
        XCTAssertFalse(summer != summerString)
        XCTAssertFalse(summerString != summer)
        XCTAssertFalse(summer != summerStringOptional)
        XCTAssertFalse(summerStringOptional != summer)
        XCTAssert(summer != nilString)
        XCTAssert(nilString != summer)

        let summerOptional: Season? = Season.summer
        XCTAssertFalse(summerOptional != summerString)
        XCTAssertFalse(summerString != summerOptional)
        XCTAssertFalse(summerOptional != summerStringOptional)
        XCTAssertFalse(summerStringOptional != summerOptional)
        XCTAssert(summerOptional != nilString)
        XCTAssert(nilString != summerOptional)

        let nilSummer: Season? = nil
        XCTAssert(nilSummer != summerString)
        XCTAssert(summerString != nilSummer)
        XCTAssert(nilSummer != summerStringOptional)
        XCTAssert(summerStringOptional != nilSummer)
        XCTAssertFalse(nilSummer != nilString)
        XCTAssertFalse(nilString != nilSummer)
    }
}
