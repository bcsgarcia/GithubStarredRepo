//
//  GithubServiceMock.swift
//  GithubMostPopularTests
//
//  Created by Garcia, Bruno (B.C.) on 06/05/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation
@testable import GithubMostPopular

class GithubServiceMock: GithubServiceProtocol {
    
    var completeClosure: ((GitResponse?, RequestError?) -> ())!
    
    func fetchStarredRepo(page: Int, completion: @escaping (GitResponse?, RequestError?) -> ()) {
        completeClosure = completion
    }
    
    func fetchSuccess() {
        completeClosure(GitResponseMock.shared.generateMock(), nil)
    }
    
    func fetchFail(error: RequestError?) {
        completeClosure( nil, error )
    }
}
