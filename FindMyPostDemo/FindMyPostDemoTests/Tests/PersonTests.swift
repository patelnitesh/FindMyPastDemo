//
//  PersonTests.swift
//  FindMyPostDemoTests
//
//  Created by Nitesh Patel on 23/05/2022.
//

import XCTest
@testable import FindMyPostDemo

class PersonTests: XCTestCase {
    var subject: Person!
    
    override func setUpWithError() throws {
        subject = Person.dummyPerson()
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    func testCheckAllComputedProperties(){
        XCTAssertNotNil(subject)
        XCTAssertEqual(subject.fullName,"FNAME SNAME")
        XCTAssertEqual(subject.dateOfBirth,"01-01-1900")
        XCTAssertNil(subject.imageURL)
    }

}
