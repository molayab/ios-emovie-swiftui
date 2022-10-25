//
//  ResponseModel.swift
//  eMovie
//
//  Created by Mateo Olaya on 24/10/22.
//

import Foundation

struct ResponseModel<Model: Codable>: Codable {
    var page: Int
    var results: [Model]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
}
