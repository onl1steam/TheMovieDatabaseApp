//
//  SessionServiceMock.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
@testable import TheMovieDatabase

final class SessionServiceMock: Session {
    
    var sessionId: String?
    var accountId: Int?
    
    var isDeletingSuccessful: Bool = false
    
    func deleteSession(_ completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(isDeletingSuccessful))
    }
    
    func setupSessionId(sessionId: String) {
        self.sessionId = sessionId
    }
    
    func setupAccountId(accountId: Int) {
        self.accountId = accountId
    }
    
    func accountInfo(_ completion: @escaping (Result<AccountDetails, Error>) -> Void) {
        let avatar = AccountDetails.Avatar(gravatar: AccountDetails.Gravatar(hash: "hash"))
        let accountDetails = AccountDetails(
            avatar: avatar,
            id: 1,
            iso6391: "ru",
            iso31661: "ru",
            name: "Artem",
            includeAdult: false,
            username: "onl1steam")
            completion(.success(accountDetails))
    }
    
    func favoriteMovies(
        language: String?,
        sortBy: String?,
        page: Int?,
        _ completion: @escaping (Result<MovieList, Error>) -> Void) {
        
        let result = MovieList.MoviesResult(id: 1)
        let movieList = MovieList(
            page: 1,
            results: [result],
            totalPages: 1,
            totalResults: 1)
        completion(.success(movieList))
    }
   
}
