//
//  MockAPIClient.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 28.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
@testable import TheMovieDatabaseAPI

private final class EndpointHandler {
    var endpoint: Any!
    var errorHandler: (Error) -> Void = { _ in }
    var responseHandler: (Any) -> Void = { _ in }
}

final class MockAPIClient: APIClient {
    
    typealias APIResult<T> = Result<T, Error>

    private var endpointHandlers: [EndpointHandler] = []

    var numberOfRequests: Int { endpointHandlers.count }

    var progress = Progress()

    func fail<E>(_ type: E.Type, with error: Error) -> E? where E: Endpoint {
        for (index, handler) in endpointHandlers.enumerated() where handler.endpoint is E {
            handler.errorHandler(error)
            endpointHandlers.remove(at: index)
            return handler.endpoint as? E
        }
        return nil
    }

    func fulfil<E, T>(_ type: E.Type, with value: T) -> E? where E: Endpoint, T == E.Content {
        for (index, handler) in endpointHandlers.enumerated() where handler.endpoint is E {
            handler.responseHandler(APIResult.success(value))
            endpointHandlers.remove(at: index)
            return handler.endpoint as? E
        }
        return nil
    }

    @discardableResult
    func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (APIResult<T.Content>) -> Void) -> Progress where T: Endpoint {

        let handler = EndpointHandler()
        handler.endpoint = endpoint
        handler.errorHandler = { (error: Error) in
            completionHandler(APIResult<T.Content>.failure(error))
        }
        handler.responseHandler = { (value: Any) in
            completionHandler(value as! APIResult<T.Content>)
        }
        endpointHandlers.append(handler)
        return progress
    }
}
