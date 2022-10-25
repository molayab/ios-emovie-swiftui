//
//  MoviesUseCaseMock.swift
//  eMovieTests
//
//  Created by Mateo Olaya on 25/10/22.
//

import Foundation
@testable import eMovie

struct MoviesUseCaseMock: MoviesUseCaseProtocol {
    var getUpcoming_result: Result<ResponseModel<MovieModel>, Error>
    var getTopRelated_result: Result<ResponseModel<MovieModel>, Error>
    var getId_result: Result<MovieModel, Error>
    var getVideos_result: Result<VideosModel, Error>
    
    func getUpcoming() async -> Result<ResponseModel<MovieModel>, Error> {
        return getUpcoming_result
    }
    
    func getTopRelated() async -> Result<ResponseModel<MovieModel>, Error> {
        return getTopRelated_result
    }
    
    func get(id: Int) async -> Result<MovieModel, Error> {
        return getId_result
    }
    
    func getVideos(id: Int) async -> Result<VideosModel, Error> {
        return getVideos_result
    }
}

struct SearchUseCaseMock: SearchUseCaseProtocol {
    var query_result: Result<ResponseModel<MovieModel>, Error>
    
    func query(_ q: String, year: String) async -> Result<ResponseModel<MovieModel>, Error> {
        return query_result
    }
}
