//
//  EndpointDefaultMethods.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 21.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

struct EndpointDefaultMethods {
    
    static func checkErrors(data: Data?, response: URLResponse?) throws {
        guard let resp = response as? HTTPURLResponse else { throw NetworkError.notHTTPResponse }
        guard (200...300).contains(resp.statusCode) else {
            switch resp.statusCode {
            case 7:
                throw NetworkError.invalidApiKey
            case 401:
                throw NetworkError.unauthorized
            case 404:
                throw NetworkError.notFound
            default:
                throw NetworkError.unknownError
            }
        }
    }
    
    static func parseDecodable<T: Decodable>(data: Data?, decodableType: T.Type) throws -> T {
        guard let data = data else { throw NetworkError.blankData }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let item = try decoder.decode(T.self, from: data)
            return item
        } catch {
            throw error
        }
    }
    
    static func encodeBody<T: Encodable>(data: T) throws -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        do {
            let data = try encoder.encode(data)
            return data
        } catch {
            throw error
        }
    }
}
