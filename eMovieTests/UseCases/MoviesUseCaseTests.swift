//
//  MoviesUseCaseTests.swift
//  eMovieTests
//
//  Created by Mateo Olaya on 25/10/22.
//

import XCTest
@testable import eMovie

final class MoviesUseCaseTests: XCTestCase {
    func testUpcomingSuccess() async throws {
        // Given
        let sut: MoviesUseCaseProtocol = buildSuccessSut()
        
        // When
        let res = await sut.getUpcoming()
        
        // Then
        guard case .success(let success) = res else {
            return XCTFail("Invalid status for a success testing")
        }

        XCTAssertEqual(success.results.count, 1)
    }
    
    func testTopSuccess() async throws {
        // Given
        let sut: MoviesUseCaseProtocol = buildSuccessSut()
        
        // When
        let res = await sut.getTopRelated()
        
        // Then
        guard case .success(let success) = res else {
            return XCTFail("Invalid status for a success testing")
        }

        XCTAssertEqual(success.results.count, 1)
        XCTAssertEqual(success.totalResults, 1)
        XCTAssertEqual(success.results.first?.title, "TEST")
    }

    private func buildSuccessSut() -> MoviesUseCaseProtocol {
        return MoviesUseCase(
            dependencies: .init(
                webService: WebServiceMock(
                    result: .success(ResponseModel(
                        page: 1,
                        results: [
                            MovieModel(
                                id: 1,
                                adult: false,
                                title: "TEST",
                                overview: "TEST",
                                releaseDate: "2012",
                                lang: "EN",
                                voteAverage: 0.5)
                        ],
                        totalPages: 1,
                        totalResults: 1)))))
    }
}
