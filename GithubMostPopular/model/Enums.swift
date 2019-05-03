//
//  Enums.swift
//  GithubMostPopular
//
//  Created by Garcia, Bruno (B.C.) on 02/05/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation
import Alamofire

enum RequestError {
    case invalidJSON
    case url
    case noResponse
    case noData
    case noInternetConnection
    case httpError(code: Int)
}

enum UrlRouter: URLRequestConvertible {
    static let baseURLString = "https://api.github.com/search/"
    
    case getStarred(Int)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getStarred:
                return .get
            }
        }
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            
            switch self {
            case .getStarred(let number):
                relativePath = "repositories?q=language:swift&sort=stars&page=\(number)&per_page=10"
            }
            
            var url = URL(string: UrlRouter.baseURLString)!
            if let relativePath = relativePath {
                url = URL(string: UrlRouter.baseURLString + relativePath)!
                print(url)
            }
            
            
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        
        
        urlRequest.httpMethod = method.rawValue
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: nil)
        
    }
}
