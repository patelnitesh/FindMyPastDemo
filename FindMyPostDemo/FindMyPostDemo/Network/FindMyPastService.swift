//
//  FindMyPastService.swift
//  FindMyPostDemo
//
//  Created by Nitesh Patel on 18/05/2022.
//

import Foundation
import Combine



protocol FindMyPastService {
    func requestProfiles(from endpoint: APIEndPoint) -> AnyPublisher<Response, APIError>
    func requestProfile(from endpoint: APIEndPoint) -> AnyPublisher<ProfileResponse, APIError>
}

struct FMPService: FindMyPastService {
    
    func requestProfiles(from endpoint: APIEndPoint) -> AnyPublisher<Response, APIError> {
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        print(endpoint.urlRequest)
        
        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<Response, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown)
                        .eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: Response.self, decoder: jsonDecoder)
                        .mapError {_ in .decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .errorCode(response.statusCode))
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    //TODO: Merge 👆🏻 and 👇🏻 function together
    func requestProfile(from endpoint: APIEndPoint) -> AnyPublisher<ProfileResponse, APIError> {
        print("Calling for \(endpoint)")
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<ProfileResponse, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown)
                        .eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: ProfileResponse.self, decoder: jsonDecoder)
                        .mapError {_ in .decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .errorCode(response.statusCode))
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}



