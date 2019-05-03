//
//  Repository.swift
//  GithubMostPopular
//
//  Created by Garcia, Bruno (B.C.) on 02/05/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

class Repository: Codable {
    var name: String?
    var owner: User?
    var starCount: Int?
    
    enum CodingKeys:String,CodingKey {
        case name = "name"
        case owner = "owner"
        case starCount = "stargazers_count"
    }
}
