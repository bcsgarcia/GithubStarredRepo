//
//  user.swift
//  GithubMostPopular
//
//  Created by Garcia, Bruno (B.C.) on 02/05/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

class User : Codable {
    var login : String?
    var avatarUrl : String?
    
    enum CodingKeys:String,CodingKey {
        case login = "login"
        case avatarUrl = "avatar_url"
    }
}
