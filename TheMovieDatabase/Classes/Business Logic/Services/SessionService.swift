//
//  SessionService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

/// Управляет текущей сессией пользователя.
protocol Session {
    
    /// Удаляет текущую сессию пользователя.
    func deleteSession()
    
    /// Устанавливает id текущей сессии.
    ///
    /// - Parameters:
    ///   - sessionId: id сессии.
    func setupSessionId(sessionId: String)
}

class SessionService: Session {
    
    // MARK: - Private Properties
    
    private let baseURL = URL(string: "https://api.themoviedb.org/")!
    private let apiKey = "591efe0e25fd45c1579562958b2364db"
    
    private var sessionId = ""
    let apiClient: APIClient
    
    init(apiClient: APIClient = APIRequest()) {
        self.apiClient = apiClient
    }
    
    // MARK: - Session
    
    func setupSessionId(sessionId: String) {
        self.sessionId = sessionId
    }
    
    func deleteSession() {
        let deleteSessionEndpoint = DeleteSessionEndpoint(baseURL: baseURL, apiKey: apiKey, sessionId: sessionId)
        apiClient.request(deleteSessionEndpoint) { response in
            switch response {
            case .success(let isSucceed):
                print(isSucceed)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
