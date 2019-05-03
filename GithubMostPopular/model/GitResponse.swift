//
//  Response.swift
//  GithubMostPopular
//
//  Created by Garcia, Bruno (B.C.) on 02/05/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

class GitResponse: Codable {
    var total: Int?
    var incompleteResults: Bool?
    var items: [Repository]?
    
    enum CodingKeys: String,CodingKey {
        case total = "total_count"
        case incompleteResults = "incomplete_results"
        case items = "items"
    }
}
