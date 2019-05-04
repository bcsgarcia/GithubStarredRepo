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
    var fullName: String?
    var owner: User?
    var starCount: Int?
    var forkCount: Int?
    var url : String?
    var description : String?
    
    
    enum CodingKeys:String,CodingKey {
        case name = "name"
        case fullName = "full_name"
        case owner = "owner"
        case starCount = "stargazers_count"
        case forkCount = "forks_count"
        case url = "html_url"
        case description = "description"
    }
}
