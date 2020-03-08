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
    func authorizeWithUser(user: User, _ completion: @escaping (Result<String, AuthError>) -> Void)
}

class AuthRequest: AuthClient {
    private var user = User()
    private var validateParameters = [String: Any]()
    private var sessionParameters = [String: Any]()
    
    func authorizeWithUser(user: User, _ completion: @escaping (Result<String, AuthError>) -> Void) {
        self.user = user
        getSessionToken(completion)
    }
    
    private func setupRequestParameters(token: String) {
        validateParameters = ["username": user.login,
                              "password": user.password,
                              "request_token": token]
        sessionParameters = ["request_token": token]
    }
    
    private func getSessionToken(_ completion: @escaping (Result<String, AuthError>) -> Void) {
        let requestUrlString = AuthRequestConfig.createTokenURLString
        let request = AF.request(requestUrlString, method: .get)
        request.validate()
            .responseDecodable(of: AuthResponse.self) { [weak self] response in
                guard let self = self,
                    let request = response.value,
                    self.validateAuthResponse(response) == nil else {
                        completion(.failure(.unknownError))
                        return
                }
                self.setupRequestParameters(token: request.requestToken)
                if request.success {
                    self.validateWithUser(completion)
                } else {
                    completion(.failure(.unknownError))
                }
            }
    }
    
    private func validateWithUser(_ completion: @escaping (Result<String, AuthError>) -> Void) {
        let requestUrlString = AuthRequestConfig.validateSessionURLString
        let request = AF.request(requestUrlString, method: .post, parameters: validateParameters)
        request.validate()
            .responseDecodable(of: AuthResponse.self) { [weak self] response in
                guard let self = self,
                    let request = response.value,
                    self.validateAuthResponse(response) == nil else {
                        if let statusCode = response.response?.statusCode, statusCode == 401 {
                            completion(.failure(.invalidData))
                        } else {
                            completion(.failure(.unknownError))
                        }
                        return
                }
                if request.success {
                    self.createSession(completion)
                } else {
                    completion(.failure(.unknownError))
                }
            }
    }
    
    private func createSession(_ completion: @escaping (Result<String, AuthError>) -> Void) {
        let requestUrlString = AuthRequestConfig.createSessionURLString
        let request = AF.request(requestUrlString, method: .post, parameters: sessionParameters)
        request.validate()
            .responseDecodable(of: SessionResponse.self) { response in
                guard let request = response.value,
                    self.validateSessionResponse(response) == nil else {
                        completion(.failure(.unknownError))
                        return
                }
                if let isSucceed = request.success, let sessionId = request.sessionId, isSucceed {
                    completion(.success(sessionId))
                } else {
                    completion(.failure(.unknownError))
                }
            }
    }
    
    private func validateSessionResponse(_ response: DataResponse<SessionResponse, AFError>) -> AFError? {
        switch response.result {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
    
    private func validateAuthResponse(_ response: DataResponse<AuthResponse, AFError>) -> AFError? {
        switch response.result {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
