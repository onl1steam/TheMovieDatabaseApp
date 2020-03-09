//
//  SessionService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

protocol Session {
    func deleteSession()
    func setupSessionId(sessionId: String)
}

class SessionService: Session {
    private var sessionId = ""
    var authClient: AuthClient
    
    init(authClient: AuthClient = AuthRequest()) {
        self.authClient = authClient
    }
    
    func setupSessionId(sessionId: String) {
        self.sessionId = sessionId
    }
    
    func deleteSession() {
        authClient.deleteSession(sessionId: sessionId)
    }
}
