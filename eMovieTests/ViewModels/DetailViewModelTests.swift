//
//  DetailViewModelTests.swift
//  eMovieTests
//
//  Created by Mateo Olaya on 25/10/22.
//

import XCTest
@testable import eMovie

final class DetailViewModelTests: XCTestCase {
    func testFetchDetailSuccess() async throws {
        // Given
        let sut = DetailViewModel(
            id: 1,
            dependencies: .init(
                moviesUseCase: MoviesUseCaseMock(
                    getUpcoming_result: .failure(NSError()),
                    getTopRelated_result: .failure(NSError()),
                    getId_result: .success(.init(
                        id: 1,
                        adult: false,
                        title: "TEST",
                        overview: "OVERVIEW",
                        releaseDate: "DATE",
                        lang: "EN",
                        voteAverage: 0)),
                    getVideos_result: .failure(NSError()))))
        
        // When
        await sut.fetch()
        
        // Then
        XCTAssertNotNil(sut.movie)
        XCTAssertEqual(sut.movie?.id, 1)
    }

}
