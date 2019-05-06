//
//  GithubMostPopularTests.swift
//  GithubMostPopularTests
//
//  Created by Garcia, Bruno (B.C.) on 02/05/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import XCTest
@testable import GithubMostPopular

@testable import GithubMostPopular

class GithubMostPopularTests: XCTestCase {

    var githubService: GithubServiceMock?
    var sut: RepositoryListViewModel?
    
    
    override func setUp() {
        githubService = GithubServiceMock()
        sut = RepositoryListViewModel(githubService: githubService!)
    }
    
    func test_generate_response_mock(){
        let sutResponse = GitResponseMock.shared.generateMock()
        if let items = sutResponse.items {
            XCTAssertEqual(items.count, 50, "resultado deve ter 50 itens por pagina - Esperado: 50 / Encontrado: \(items.count)")
        } else {
            XCTFail("Falha ao gerar Mock, não retornou nenhum item")
        }
    }
    
    func test_service_when_Api_result_is_ok(){
        
        guard let sut = sut else {
            XCTFail("sut não foi inicializado")
            return
        }
        
        guard let githubService = githubService else {
            XCTFail("githubService não foi inicializado")
            return
        }
        
        
        let expectation = self.expectation(description: "fetchngData")
        sut.didFinishFetch = { expectation.fulfill() }
        
        sut.fetchData()
        githubService.fetchSuccess()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(sut.repositoriesCellViewModels.count, 50, "resultado deve ter 50 itens por pagina - Esperado: 50 / Encontrado: \(sut.repositoriesCellViewModels.count)")
        
        if sut.repositoriesCellViewModels.count > 0 {
            XCTAssertEqual(sut.repositoriesCellViewModels[0].name , "awesome-ios", "Esperado: awesome-ios / Encontrado \(sut.repositoriesCellViewModels[0].name)")
        } else {
            XCTFail("sut.movieCellViewModels must have object list")
        }
    }
    
    func test_when_service_fail(){
        
        guard let sut = sut else {
            XCTFail("sut não foi inicializado")
            return
        }
        
        guard let githubService = githubService else {
            XCTFail("githubService não foi inicializado")
            return
        }
        
        let expectation = self.expectation(description: "fetchngData")
        sut.showAlertClosure = { expectation.fulfill() }
        
        sut.fetchData()
        githubService.fetchFail(error: .invalidJSON)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(sut.error, "sut error deve ser .invalidJSON")
    }
    
    override func tearDown() {
        githubService = nil
        sut = nil
    }

}
