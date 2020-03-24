//
//  MoviesServiceTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 24.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class MoviesServiceTests: XCTestCase {
    
    // Id фильма "Джокер"
    let movieId = 475557
    
    var moviesService: MoviesServiceType!
    
    override func setUp() {
        super.setUp()
        moviesService = ServiceLayer.shared.moviesService
    }
    
    func testSearchMovies() {
        let exp = expectation(description: "Загрузка фильмов с результатом")
        moviesService.searchMovies(query: "Звёздные войны") { response in
            switch response {
            case .success(let movies):
                XCTAssert(movies.totalResults != 0)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testSearchMoviesWithEmptyResult() {
        let exp = expectation(description: "Загрузка фильмов без результата")
        moviesService.searchMovies(query: "TestTestTest") { response in
            switch response {
            case .success(let movies):
                XCTAssert(movies.totalResults == 0)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testSearchMoviesWithEmptySearchField() {
        let exp = expectation(description: "Загрузка фильмов с пустой строкой поиска")
        moviesService.searchMovies(query: "") { response in
            switch response {
            case .success:
                XCTFail("Запрос должен выдать ошибку")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Неизвестная ошибка, попробуйте позже.")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testSearchForMovieDetails() {
        let exp = expectation(description: "Загрузка подробностей фильма на русском")
        moviesService.movieDetails(movieId: movieId, language: "ru") { response in
            switch response {
            case .success(let movieDetails):
                XCTAssertEqual(movieDetails.title, "Джокер")
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testSearchForMovieDetailsWithoutLanguage() {
        let exp = expectation(description: "Загрузка подробностей фильма без указания языка")
        moviesService.movieDetails(movieId: movieId, language: nil) { response in
            switch response {
            case .success(let movieDetails):
                XCTAssertEqual(movieDetails.title, "Joker")
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testSearchForMovieDetailsWithInvalidId() {
        let exp = expectation(description: "Загрузка подробностей фильма с невалидным id")
        moviesService.movieDetails(movieId: 0, language: nil) { response in
            switch response {
            case .success:
                XCTFail("Фильма с id 0 не должно существовать")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Запрашиваемый ресурс не найден.")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
}
