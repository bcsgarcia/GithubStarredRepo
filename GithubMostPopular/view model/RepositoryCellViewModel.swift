//
//  RepositoryCellViewModel.swift
//  GithubMostPopular
//
//  Created by Garcia, Bruno (B.C.) on 03/05/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation
import UIKit

struct RepositoryCellViewModel {
    
    let name : String
    let fullName : String
    let url : String
    let description : String
    let stars : Int
    let forks : Int
    let userName : String
    let userAvatarUrl : String
    
    
    init(repository: Repository) {
        self.name = repository.name ?? ""
        self.stars = repository.starCount ?? 0
        self.forks = repository.forkCount ?? 0
        self.fullName = repository.fullName ?? ""
        self.description = repository.description ?? ""
        self.url = repository.url ?? ""
        
        if let user = repository.owner {
            self.userName = user.login ?? ""
            self.userAvatarUrl = user.avatarUrl ?? ""
        } else {
            self.userName = ""
            self.userAvatarUrl = ""
        }
    }
}
