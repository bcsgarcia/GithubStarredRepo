//
//  GitResponseMock.swift
//  GithubMostPopularTests
//
//  Created by Garcia, Bruno (B.C.) on 06/05/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation
@testable import GithubMostPopular

class GitResponseMock: GitResponse {
    
    static let shared : GitResponseMock = GitResponseMock()
    
    func generateMock() -> GitResponse {
        do {
            guard let asset = NSDataAsset(name: "repo_response_mock", bundle: Bundle.main) else { return MostPopularResponse() }
            let mostPopular = try JSONDecoder().decode(MostPopularResponse.self, from: asset.data)
            return mostPopular
            
        } catch let jsonErr {
            print("Failed to decode:", jsonErr)
            return MostPopularResponse()
        }
    }
    
    
}
