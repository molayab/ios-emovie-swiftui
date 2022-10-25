//
//  HomeViewModel.swift
//  eMovie
//
//  Created by Mateo Olaya on 24/10/22.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func fetchDiscover(forLang: String, year: String) async
    func fetchUpcoming() async
    func fetchTrending() async
}

final class HomeViewModel: ObservableObject, HomeViewModelProtocol {
    struct Dependencies: DomainAllowed {
        var moviesUseCase: MoviesUseCaseProtocol = inject()
        var searchUseCase: SearchUseCaseProtocol = inject()
    }
    
    let dependencies: Dependencies
    @Published private(set) var upcomingList: [MovieModel] = []
    @Published private(set) var trendingList: [MovieModel] = []
    @Published private(set) var recommendedList: [MovieModel] = []
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
    
    func fetchDiscover(forLang: String, year: String) async {
        let response = await dependencies.searchUseCase.query(forLang, year: year)
        
        switch response {
        case .success(let model):
            await MainActor.run {
                self.recommendedList = model.results
            }
            
        case .failure(let error):
            self.recommendedList = []
            print(error)
        }
    }
    
    func fetchUpcoming() async {
        let response = await dependencies.moviesUseCase.getUpcoming()

        switch response {
        case .success(let model):
            await MainActor.run {
                self.upcomingList = model.results
            }
        case .failure(let error):
            self.upcomingList = []
            print(error)
        }
    }
    
    func fetchTrending() async {
        let response = await dependencies.moviesUseCase.getTopRelated()
        
        switch response {
        case .success(let model):
            await MainActor.run {
                self.trendingList = model.results
            }
        case .failure(let error):
            print(error)
        }
    }
}
