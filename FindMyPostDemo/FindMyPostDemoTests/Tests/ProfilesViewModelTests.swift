//
//  ProfilesViewModelTests.swift
//  FindMyPostDemoTests
//
//  Created by Nitesh Patel on 23/05/2022.
//

import XCTest
import Combine
@testable import FindMyPostDemo

class ProfilesViewModelTests: XCTestCase {
    
    var subject: ProfilesViewModel!
    var mockApiService: MockApiService!
    private var cancellable: Set<AnyCancellable> = []

    override func setUpWithError() throws {
                                                                
        let profiles = Bundle.main.decode(Response.self, from: "Profiles.json")
        mockApiService = MockApiService()
        mockApiService.fetchProfiles = Result.success(profiles).publisher.eraseToAnyPublisher()
        subject = ProfilesViewModel(service: mockApiService, username: "FakeUsername")
        
    }

    override func tearDownWithError() throws {
        subject = nil
        mockApiService = nil
    }
    
    func test_VMLoad() {
        XCTAssertTrue(mockApiService.getProfilesCalled)
        // Should have correct number of profiles loaded
        XCTAssertEqual(subject.profiles.count, 16)
    }

}
