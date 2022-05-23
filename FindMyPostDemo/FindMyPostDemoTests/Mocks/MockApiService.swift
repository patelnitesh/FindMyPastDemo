//
//  MockApiService.swift
//  FindMyPostDemoTests
//
//  Created by Nitesh Patel on 23/05/2022.
//

import Combine
@testable import FindMyPostDemo

class MockApiService: FindMyPastService {
    
    var getProfilesCalled = false
    var fetchProfiles: AnyPublisher<Response, APIError>!
    func requestProfiles(from endpoint: APIEndPoint) -> AnyPublisher<Response, APIError> {
        getProfilesCalled = true
        return fetchProfiles
    }
    
    var getProfileCalled = false
    var fetchProfile: AnyPublisher<ProfileResponse, APIError>!
    func requestProfile(from endpoint: APIEndPoint) -> AnyPublisher<ProfileResponse, APIError> {
        getProfileCalled = true
        return fetchProfile
    }

}
