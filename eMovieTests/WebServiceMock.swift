//
//  WebServiceMock.swift
//  eMovieTests
//
//  Created by Mateo Olaya on 25/10/22.
//

import Foundation
@testable import eMovie

struct WebServiceMock<Model: Codable>: WebServiceProtocol {
    var result: Result<Model, Error>
    
    func exec<Model>(request: WebServiceRequest) async -> Result<Model, Error> {
        return result as! Result<Model, Error>
    }
}
