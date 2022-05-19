//
//  ApiEndpoint.swift
//  FindMyPostDemo
//
//  Created by Nitesh Patel on 18/05/2022.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}


enum APIEndPoint {
    case getProfiles(userId: String)
    case getProfile(userId: String, personId: String)
}

// http://localhost:3001/profiles/:userId
// http://localhost:3001/profiles/cgriswold


// http://localhost:3001/profile/:personId/:userId.
// http://localhost:3001/profile/002/cgriswold

extension APIEndPoint: APIBuilder {

    var baseUrl: URL {
            return URL(string: "http://localhost:3001")!
    }
    
    var path: String {
        switch self {
        case .getProfiles(let userId):
            return "/profiles/\(userId)"
        case .getProfile(let userId, let personId) :
            return "/profile/\(personId)/\(userId)"
        }
    }
    
    var urlRequest: URLRequest {
        switch self {
        case .getProfiles:
            return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
        case .getProfile:
            return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
        }
    }
}

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the error from the service"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "The error is unknown"
        }
    }
}
