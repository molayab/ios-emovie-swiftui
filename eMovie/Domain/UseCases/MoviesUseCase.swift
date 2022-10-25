//
//  MoviesUseCase.swift
//  eMovie
//
//  Created by Mateo Olaya on 24/10/22.
//

import Foundation

protocol MoviesUseCaseProtocol {
    func getUpcoming() async -> Result<ResponseModel<MovieModel>, Error>
    func getTopRelated() async -> Result<ResponseModel<MovieModel>, Error>
    func get(id: Int) async -> Result<MovieModel, Error>
    func getVideos(id: Int) async -> Result<VideosModel, Error>
}

final class MoviesUseCase {
    struct Dependencies: DomainAllowed {
        var webService: WebServiceProtocol = inject()
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
}

extension MoviesUseCase: MoviesUseCaseProtocol {
    func getVideos(id: Int) async -> Result<VideosModel, Error> {
        return await dependencies.webService.exec(request: MoviesService.videosForId(id))
    }
    
    func get(id: Int) async -> Result<MovieModel, Error> {
        return await dependencies.webService.exec(request: MoviesService.byId(id))
    }
    
    func getUpcoming() async -> Result<ResponseModel<MovieModel>, Error> {
        return await dependencies.webService.exec(request: MoviesService.upcoming)
    }
    
    func getTopRelated() async -> Result<ResponseModel<MovieModel>, Error> {
        return await dependencies.webService.exec(request: MoviesService.top)
    }
}

extension DomainAllowed {
    static func inject() -> MoviesUseCaseProtocol {
        return MoviesUseCase()
    }
}
