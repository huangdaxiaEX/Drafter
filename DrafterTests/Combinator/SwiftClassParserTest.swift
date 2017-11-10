//
//  SwiftClassParserTest.swift
//  DrafterTests
//
//  Created by LZephyr on 2017/11/10.
//

import XCTest

class SwiftClassParserTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testClass() {
        let tokens = SourceLexer(input: "class MyClass: Super, Proto1, Proto2", isSwift: true).allTokens
        guard let cls = SwiftClassGenParser().parser.run(tokens) else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(cls.count == 1)
        XCTAssert(cls[0].className == "MyClass")
        XCTAssert(cls[0].superCls!.className == "Super")
        XCTAssert(cls[0].protocols == ["Proto1", "Proto2"])
    }
    
    func testClassNoInherit() {
        let tokens = SourceLexer(input: "class MyClass", isSwift: true).allTokens
        guard let cls = SwiftClassGenParser().parser.run(tokens) else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(cls.count == 1)
        XCTAssert(cls[0].className == "MyClass")
        XCTAssert(cls[0].superCls == nil)
        XCTAssert(cls[0].protocols.count == 0)
    }
    
    func testClassWithGeneric() {
        let tokens = SourceLexer(input: "class MyClass<T, A>: Super", isSwift: true).allTokens
        guard let cls = SwiftClassGenParser().parser.run(tokens) else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(cls.count == 1)
        XCTAssert(cls[0].className == "MyClass")
        XCTAssert(cls[0].superCls!.className == "Super")
        XCTAssert(cls[0].protocols.count == 0)
    }
}