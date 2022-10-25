//
//  MovieModel.swift
//  eMovie
//
//  Created by Mateo Olaya on 24/10/22.
//

import Foundation

struct MovieModel: Codable {
    var id: Int
    var adult: Bool
    var title: String
    var overview: String
    var posterPath: String?
    var releaseDate: String
    var genres: [GenreModel]?
    var backdropPath: String?
    var lang: String
    var voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genres
        case backdropPath = "backdrop_path"
        case lang = "original_language"
        case voteAverage = "vote_average"
    }
}
