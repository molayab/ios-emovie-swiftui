//
//  SerachService.swift
//  eMovie
//
//  Created by Mateo Olaya on 25/10/22.
//

import Foundation

enum SearchService: WebServiceRequest {
    case movies(String, String)
    
    var endpoint: String {
        return "https://api.themoviedb.org/3"
    }
    
    var path: String {
        switch self {
        case .movies(let q, let year):
            return "/search/movie?query=\(q)&year=\(year)"
        }
    }
}
