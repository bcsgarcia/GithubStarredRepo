//
//  RepositoryListViewModel.swift
//  GithubMostPopular
//
//  Created by Garcia, Bruno (B.C.) on 03/05/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

class RepositoryListViewModel {
    
    // MARK: - Properties
    private var mostPopular: GitResponse? {
        didSet {
            guard let mp = mostPopular else { return }
            self.setupProperties(with: mp)
            self.didFinishFetch?()
        }
    }
    
    var page = 0
    //var totalPages = 0
    var repositoriesCellViewModels = [RepositoryCellViewModel]()
    
    let githubService: GithubServiceProtocol
    
    var error: RequestError? {
        didSet { self.showAlertClosure?() }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?() }
    }
    
    // Dependency Injection
    init( githubService: GithubServiceProtocol = GithubService()) {
        self.githubService = githubService
    }
    
    // MARK: - Closures for callback
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    
    // MARK: - Network call
    func fetchData() {
        isLoading = true
        
        if !CheckInternet.Connection() {
            isLoading = false
            error = .noInternetConnection
            return
        }
        
        guard let page = plusOnePage() else {
            isLoading = false
            return
        }
        
        githubService.fetchStarredRepo(page: page) { (mostPopular, err) in
            if let err = err {
                self.isLoading = false
                self.error = err
                return
            }
            guard let mostPopular = mostPopular else {
                self.isLoading = false
                return
            }
            self.error = nil
            self.isLoading = false
            self.mostPopular = mostPopular
        }
    }
    
    // MARK: - UI Logic
    private func plusOnePage() -> Int? {
        page += 1
        return page
    }
    
    private func setupProperties(with mostPopular: GitResponse) {
        if let repositoryList = mostPopular.items {
            self.repositoriesCellViewModels = self.repositoriesCellViewModels +  repositoryList.map({return RepositoryCellViewModel(repository: $0)})
            print(self.repositoriesCellViewModels.count)
        }
    }
    
}
