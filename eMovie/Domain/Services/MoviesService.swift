//
//  UpcomingService.swift
//  eMovie
//
//  Created by Mateo Olaya on 24/10/22.
//

import Foundation

enum MoviesService: WebServiceRequest {
    case upcoming
    case top
    case byId(Int)
    case videosForId(Int)
    
    var endpoint: String {
        return "https://api.themoviedb.org/3"
    }
    
    var path: String {
        switch self {
        case .upcoming:
            return "/movie/upcoming"
        case .top:
            return "/movie/top_rated"
        case .byId(let id):
            return "/movie/\(id)"
        case .videosForId(let id):
            return "/movie/\(id)/videos"
        }
    }
}
