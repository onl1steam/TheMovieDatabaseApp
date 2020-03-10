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
    func authorizeWithUser(_ user: User, _ completion: @escaping (Result<String, AuthError>) -> Void)
    func deleteSession(sessionId: String)
}

class AuthRequest: AuthClient {
    private var user = User()
    private var validateParameters = [String: Any]()
    private var sessionParameters = [String: Any]()
    
    func authorizeWithUser(_ user: User, _ completion: @escaping (Result<String, AuthError>) -> Void) {
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
        request.validate().responseDecodable(of: AuthResponse.self) { [weak self] response in
                guard let self = self,
                    let responseData = response.value,
                    self.validateAuthResponse(response) == nil else {
                        completion(.failure(.unknownError))
                        return
                }
                self.setupRequestParameters(token: responseData.requestToken)
                if responseData.success {
                    self.validateUserData(completion)
                } else {
                    completion(.failure(.unknownError))
                }
        }
    }
    
    private func validateUserData(_ completion: @escaping (Result<String, AuthError>) -> Void) {
        let requestUrlString = AuthRequestConfig.validateSessionURLString
        let request = AF.request(requestUrlString, method: .post, parameters: validateParameters)
        request.validate().responseDecodable(of: AuthResponse.self) { [weak self] response in
                guard let self = self,
                    let responseData = response.value,
                    self.validateAuthResponse(response) == nil else {
                        if let statusCode = response.response?.statusCode, statusCode == 401 {
                            completion(.failure(.invalidInput))
                        } else {
                            completion(.failure(.unknownError))
                        }
                        return
                }
                if responseData.success {
                    self.createSession(completion)
                } else {
                    completion(.failure(.unknownError))
                }
        }
    }
    
    private func createSession(_ completion: @escaping (Result<String, AuthError>) -> Void) {
        let requestUrlString = AuthRequestConfig.createSessionURLString
        let request = AF.request(requestUrlString, method: .post, parameters: sessionParameters)
        request.validate().responseDecodable(of: SessionResponse.self) { response in
                guard let responseData = response.value,
                    self.validateSessionResponse(response) == nil else {
                        completion(.failure(.unknownError))
                        return
                }
                if let isSucceed = responseData.success, let sessionId = responseData.sessionId, isSucceed {
                    completion(.success(sessionId))
                } else {
                    completion(.failure(.unknownError))
                }
        }
    }
    
    func deleteSession(sessionId: String) {
        let requestUrlString = AuthRequestConfig.deleteSessionURLString
        let parameters = ["session_id": sessionId]
        AF.request(requestUrlString, method: .delete, parameters: parameters)
            .responseDecodable(of: DeleteSessionResponse.self) { response in
                guard let responseData = response.value,
                    let isSucceed = responseData.success,
                    isSucceed else {
                        print("Ошибка удаления сессии")
                        return
                }
                print("Сессия успешно удалена")
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
