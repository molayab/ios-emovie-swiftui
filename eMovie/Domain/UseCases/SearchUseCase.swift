//
//  SearchUseCase.swift
//  eMovie
//
//  Created by Mateo Olaya on 25/10/22.
//

import Foundation

protocol SearchUseCaseProtocol {
    func query(_ q: String, year: String) async -> Result<ResponseModel<MovieModel>, Error>
}

final class SearchUseCase {
    struct Dependencies: DomainAllowed {
        var webService: WebServiceProtocol = inject()
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
}

extension SearchUseCase: SearchUseCaseProtocol {
    func query(_ q: String, year: String) async -> Result<ResponseModel<MovieModel>, Error> {
        let response: Result<ResponseModel<MovieModel>, Error>
            = await dependencies.webService.exec(request: SearchService.movies(q, year))
        
        switch response {
        case .success(let success):
            return .success(.init(
                page: 1,
                results: Array(success.results.compactMap { movie in
                    if let posterPath = movie.posterPath, posterPath.isEmpty {
                        return nil
                    }
                    
                    return movie
                }.suffix(6)),
                totalPages: 1,
                totalResults: 6))
        case .failure(let failure):
            return .failure(failure)
        }
    }
}

extension DomainAllowed {
    static func inject() -> SearchUseCaseProtocol {
        return SearchUseCase()
    }
}
