//
//  GithubService.swift
//  GithubMostPopular
//
//  Created by Garcia, Bruno (B.C.) on 02/05/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation
import Alamofire

protocol GithubServiceProtocol {
    func fetchStarredRepo(page: Int, completion: @escaping (GitResponse?, RequestError?) -> ())
}

class GithubService : GithubServiceProtocol {
   
    func fetchStarredRepo(page: Int, completion: @escaping (GitResponse?, RequestError?) -> ()) {
        Alamofire.request(UrlRouter.getStarred(page))
            .responseJSON { (response) in
                if response.result.value == nil {
                    completion(nil, .noResponse)
                    return
                }
                guard let data = response.data else {
                    completion(nil, .noData)
                    return
                }
                
                do {
                    print(response)
                    let mostPopular = try JSONDecoder().decode(GitResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(mostPopular, nil)
                    }
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                }
        }
    }
}
