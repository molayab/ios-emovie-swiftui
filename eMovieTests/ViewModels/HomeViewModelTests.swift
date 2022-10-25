//
//  HomeViewModelTests.swift
//  eMovieTests
//
//  Created by Mateo Olaya on 25/10/22.
//

import XCTest
@testable import eMovie

final class HomeViewModelTests: XCTestCase {

    func testFetchTrendingSuccess() async throws {
        // Given
        let sut = HomeViewModel(
            dependencies: .init(
                moviesUseCase: MoviesUseCaseMock(
                    getUpcoming_result: .failure(NSError()),
                    getTopRelated_result: .success(.init(
                        page: 1,
                        results: [
                            .init(
                                id: 1,
                                adult: false,
                                title: "TEST",
                                overview: "OVERVIEW",
                                releaseDate: "RD",
                                lang: "EN",
                                voteAverage: 0)
                        ],
                        totalPages: 1,
                        totalResults: 1)),
                    getId_result: .failure(NSError()),
                    getVideos_result: .failure(NSError()))))
        
        // When
        await sut.fetchTrending()
        
        // Then
        XCTAssertFalse(sut.trendingList.isEmpty)
        XCTAssertEqual(sut.trendingList.first?.id, 1)
        XCTAssertTrue(sut.upcomingList.isEmpty)
    }
    
    func testFetchUpcomingSuccess() async throws {
        // Given
        let sut = HomeViewModel(
            dependencies: .init(
                moviesUseCase: MoviesUseCaseMock(
                    getUpcoming_result: .success(.init(
                        page: 1,
                        results: [
                            .init(
                                id: 1,
                                adult: false,
                                title: "TEST",
                                overview: "OVERVIEW",
                                releaseDate: "RD",
                                lang: "EN",
                                voteAverage: 0)
                        ],
                        totalPages: 1,
                        totalResults: 1)),
                    getTopRelated_result: .failure(NSError()),
                    getId_result: .failure(NSError()),
                    getVideos_result: .failure(NSError()))))
        
        // When
        await sut.fetchUpcoming()
        
        // Then
        XCTAssertTrue(sut.trendingList.isEmpty)
        XCTAssertFalse(sut.upcomingList.isEmpty)
        XCTAssertEqual(sut.upcomingList.first?.id, 1)
    }
    
    func testDiscoverSuccess() async throws {
        // Given
        let sut = HomeViewModel(
            dependencies: .init(
                searchUseCase: SearchUseCaseMock(query_result: .success(.init(
                    page: 1,
                    results: [
                        .init(
                            id: 1,
                            adult: false,
                            title: "TEST",
                            overview: "OVERVIEW",
                            releaseDate: "RD",
                            lang: "EN",
                            voteAverage: 0)
                    ],
                    totalPages: 1,
                    totalResults: 1)))))
        
        // When
        await sut.fetchDiscover(forLang: "en", year: "0000")
        
        // Then
        XCTAssertFalse(sut.recommendedList.isEmpty)
        XCTAssertEqual(sut.recommendedList.first?.id, 1)
    }
}
