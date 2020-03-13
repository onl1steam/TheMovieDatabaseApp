//
//  SessionService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

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
    
    // MARK: - Public Properties
    
    var authClient: AuthClient
    
    // MARK: - Private Properties
    
    private var sessionId = ""
    
    // MARK: - Initializers
    
    init(authClient: AuthClient = AuthRequest()) {
        self.authClient = authClient
    }
    
    // MARK: - Session
    
    func setupSessionId(sessionId: String) {
        self.sessionId = sessionId
    }
    
    func deleteSession() {
        authClient.deleteSession(sessionId: sessionId)
    }
}
