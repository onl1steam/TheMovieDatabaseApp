//
//  SearchMovieEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для поиска фильмов.
public struct SearchMovieEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = MoviesResponse
    
    // MARK: - Public Properties
    
    let query: String
    let language: String?
    let page: Int?
    let includeAdult: Bool?
    let region: String?
    let year: Int?
    let primaryReleaseYear: Int?
    
    public var configuration: Configuration?
    
    // MARK: - Initializers
    
    public init(
        query: String,
        language: String?,
        page: Int?,
        includeAdult: Bool?,
        region: String?,
        year: Int?,
        primaryReleaseYear: Int?) {
        self.query = query
        self.language = language
        self.page = page
        self.includeAdult = includeAdult
        self.region = region
        self.year = year
        self.primaryReleaseYear = primaryReleaseYear
    }
    
    // MARK: - Endpoint
    
    public func makeRequest() throws -> URLRequest {
        guard let configuration = configuration else { throw NetworkError.noConfiguration }
        
        let url = makeURLPath(baseURL: configuration.baseURL)
        let queryItems = makeQueryItems(apiKey: configuration.apiKey)
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        
        guard let resultURL = urlComponents?.url else { throw NetworkError.badURL }
        var request = URLRequest(url: resultURL)
        request.httpMethod = HttpMethods.GET.rawValue
        return request
    }
    
    public func content(from: Data?, response: URLResponse?) throws -> Content {
        try EndpointDefaultMethods.checkErrors(data: from, response: response)
        let data = try EndpointDefaultMethods.parseDecodable(data: from, decodableType: Content.self)
        return data
    }
    
    // MARK: - Private Methods
    
    private func makeQueryItems(apiKey: String) -> [URLQueryItem] {
        var queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "query", value: query)
        ]
        if let lang = language {
            queryItems.append(URLQueryItem(name: "language", value: lang))
        }
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        if let includeAdult = includeAdult {
            queryItems.append(URLQueryItem(name: "include_adult", value: "\(includeAdult)"))
        }
        if let region = region {
            queryItems.append(URLQueryItem(name: "region", value: "\(region)"))
        }
        if let year = year {
            queryItems.append(URLQueryItem(name: "year", value: "\(year)"))
        }
        if let primaryReleaseYear = primaryReleaseYear {
            queryItems.append(URLQueryItem(name: "primary_release_year", value: "\(primaryReleaseYear)"))
        }
        return queryItems
    }
    
    private func makeURLPath(baseURL: URL) -> URL {
        var url = baseURL
        url.appendPathComponent("3")
        url.appendPathComponent("search")
        url.appendPathComponent("movie")
        return url
    }
}
