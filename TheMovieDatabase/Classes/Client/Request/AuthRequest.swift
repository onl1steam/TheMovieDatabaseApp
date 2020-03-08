//
//  AuthRequest.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Alamofire
import Foundation

protocol AuthClient {
    func authorizeWithUser(login: String, password: String, _ completion: @escaping (Result<String, Error>) -> Void)
}

class AuthRequest: AuthClient {
    private var login = String()
    private var password = String()
    private var validateParameters = [String: Any]()
    private var sessionParameters = [String: Any]()
    
    func authorizeWithUser(login: String, password: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        self.login = login
        self.password = password
        getSessionToken(completion)
    }
    
    private func makeParameters(token: String) {
        validateParameters = ["username": login,
                              "password": password,
                              "request_token": token]
        sessionParameters = ["request_token": token]
    }
    
    private func getSessionToken(_ completion: @escaping (Result<String, Error>) -> Void) {
        let requestUrlString = AuthRequestConfig.createTokenURLString
        let request = AF.request(requestUrlString, method: .get)
        request.validate()
            .responseDecodable(of: AuthResponse.self) { [weak self] response in
                guard let self = self, let request = response.value else { return }
                self.makeParameters(token: request.requestToken)
                self.validateWithUser(completion)
            }
    }
    
    private func validateWithUser(_ completion: @escaping (Result<String, Error>) -> Void) {
        let requestUrlString = AuthRequestConfig.validateSessionURLString
        let request = AF.request(requestUrlString, method: .post, parameters: validateParameters)
        request.validate()
            .responseDecodable(of: AuthResponse.self) { [weak self] response in
                guard let self = self, response.value != nil else { return }
                print(response)
                self.createSession(completion)
            }
    }
    
    private func createSession(_ completion: @escaping (Result<String, Error>) -> Void) {
        let requestUrlString = AuthRequestConfig.createSessionURLString
        let request = AF.request(requestUrlString, method: .post, parameters: sessionParameters)
        request.validate()
            .responseDecodable(of: SessionResponse.self) { response in
                print(response)
                guard let request = response.value else { return }
                if let success = request.success, success {
                    completion(.success(request.sessionId!))
                }
            }
    }
    
}
