//
//  MoviesServiceTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 24.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
@testable import TheMovieDatabaseAPI
import XCTest

final class MoviesServiceTests: XCTestCase {
    
    // MARK: - Public Properties
    
    var moviesService: MoviesService!
    
    var moviesListResponse: MoviesResponse!
    var movieDetailsResponse: MovieDetailsResponse!
    
    // MARK: - setUp
    
    override func setUp() {
        super.setUp()
        
        moviesListResponse = MoviesResponse(page: 1, results: [], totalPages: 1, totalResults: 5)
        movieDetailsResponse = MovieDetailsResponse(
            genres: [],
            id: 1,
            originalTitle: "Joker",
            overview: nil,
            posterPath: nil,
            releaseDate: "Foo",
            runtime: 100,
            title: "Джокер",
            voteAverage: 5,
            voteCount: 100)
    }
    
    // MARK: - Tests
    
    func testSearchMovies() {
        let apiClient = APIClientStub(responseStub: moviesListResponse, errorStub: nil)
        moviesService = MoviesService(apiClient: apiClient)
        
        moviesService.searchMovies(query: "Звёздные войны") { response in
            switch response {
            case .success(let movies):
                XCTAssert(movies.totalResults > 0)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
        }
    }
    
    func testSearchMoviesWithEmptyResult() {
        let apiClient = APIClientStub(responseStub: moviesListResponse, errorStub: nil)
        moviesService = MoviesService(apiClient: apiClient)
        
        moviesService.searchMovies(query: "TestTestTest") { response in
            switch response {
            case .success(let movies):
                XCTAssert(movies.results.isEmpty)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
        }
    }
    
    func testSearchMoviesWithEmptySearchField() {
        let apiClient = APIClientStub(responseStub: nil, errorStub: NetworkError.unknownError)
        moviesService = MoviesService(apiClient: apiClient)
        
        moviesService.searchMovies(query: "") { response in
            switch response {
            case .success:
                XCTFail("Запрос должен выдать ошибку")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Неизвестная ошибка, попробуйте позже.")
            }
        }
    }
    
    func testSearchForMovieDetails() {
        let apiClient = APIClientStub(responseStub: movieDetailsResponse, errorStub: nil)
        moviesService = MoviesService(apiClient: apiClient)
        
        moviesService.movieDetails(movieId: 1, language: "ru") { response in
            switch response {
            case .success(let movieDetails):
                XCTAssertEqual(movieDetails.title, "Джокер")
                XCTAssertEqual(movieDetails.id, 1)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
        }
    }
}
