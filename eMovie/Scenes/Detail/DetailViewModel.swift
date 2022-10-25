//
//  DetailViewModel.swift
//  eMovie
//
//  Created by Mateo Olaya on 24/10/22.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol: AnyObject {
    func fetch() async
    func showTrailer() async
}


final class DetailViewModel: ObservableObject, DetailViewModelProtocol {
    struct Dependencies: DomainAllowed {
        var moviesUseCase: MoviesUseCaseProtocol = inject()
    }
    
    @Published var movie: MovieModel? = nil
    
    let dependencies: Dependencies
    let id: Int
    
    init(id: Int, dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
        self.id = id
    }
    
    func fetch() async {
        let response = await dependencies.moviesUseCase.get(id: id)
        
        switch response {
        case .success(let movie):
            self.movie = movie
        case .failure(let error):
            print(error)
        }
    }
    
    func showTrailer() async {
        let response = await dependencies.moviesUseCase.getVideos(id: id)
        
        switch response {
        case .success(let model):
            if let trailer = model.results.first(where: { $0.official && $0.type == "Trailer" }),
               let url = URL(string: "https://www.youtube.com/watch?v=\(trailer.key)") {
                _ = await UIApplication.shared.openURL(url)
                // This could be improved but due time it will just open and external link.
            }
        case .failure(let error):
            print(error)
        }
    }
}
