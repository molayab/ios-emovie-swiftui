//
//  WebService.swift
//  eMovie
//
//  Created by Mateo Olaya on 24/10/22.
//

import Foundation


protocol WebServiceRequest {
    var endpoint: String { get }
    var path: String { get }
}

enum WebServiceRequestError: Error {
    case invalidURL
}

extension WebServiceRequest {
    func getURL() throws -> URL {
        guard let url = URL(string: endpoint + path) else {
            throw WebServiceRequestError.invalidURL
        }
        
        return url
    }
}

protocol WebServiceProtocol {
    func exec<Model: Codable>(request: WebServiceRequest) async -> Result<Model, Error>
}

final class WebService: WebServiceProtocol {
    private let secureBucket: SecureBucket
    private let session: URLSession = .shared
    
    init(secureBucket: SecureBucket = .init()) {
        self.secureBucket = secureBucket
    }
    
    func exec<Model: Codable>(request: WebServiceRequest) async -> Result<Model, Error> {
        do {
            let request = URLRequest(
                url: try request.getURL()
                    .appending(
                        queryItems: [.init(
                            name: "api_key",
                            value: secureBucket.applicationAccessToken)]),
                cachePolicy: .reloadRevalidatingCacheData)
            
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let model = try decoder.decode(Model.self, from: data)
            
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
}

extension DomainAllowed {
    static func inject() -> WebServiceProtocol {
        return WebService()
    }
}
