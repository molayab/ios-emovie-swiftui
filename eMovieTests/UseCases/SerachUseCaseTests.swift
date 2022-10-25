//
//  SerachUseCaseTests.swift
//  eMovieTests
//
//  Created by Mateo Olaya on 25/10/22.
//

import XCTest
@testable import eMovie

final class SearchUseCaseTests: XCTestCase {
    func testSearchSuccess() async throws {
        // Given
        let sut: SearchUseCaseProtocol = buildSuccessSut()
        
        // When
        let res = await sut.query("query", year: "year")
        
        // Then
        guard case .success(let success) = res else {
            return XCTFail("Invalid status for a success testing")
        }

        XCTAssertEqual(success.results.count, 6)
        XCTAssertTrue(success.results.contains(where: { $0.posterPath == nil}))
    }

    private func buildSuccessSut() -> SearchUseCaseProtocol {
        return SearchUseCase(
            dependencies: .init(
                webService: WebServiceMock(
                    result: .success(ResponseModel(
                        page: 1,
                        results: Array(
                            repeating: MovieModel(
                                id: 1,
                                adult: false,
                                title: "TEST",
                                overview: "TEST",
                                releaseDate: "2012",
                                lang: "EN",
                                voteAverage: 0.5),
                            count: 100),
                        totalPages: 1,
                        totalResults: 100)))))
    }
}

