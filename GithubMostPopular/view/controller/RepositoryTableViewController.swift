//
//  RepositoryTableViewController.swift
//  GithubMostPopular
//
//  Created by Garcia, Bruno (B.C.) on 03/05/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import UIKit

class RepositoryTableViewController: UITableViewController {

    
    var viewModel = RepositoryListViewModel()
    var repositoriesCellViewModel = [RepositoryCellViewModel]()
    var indicator = UIActivityIndicatorView()
    
    var checkInternetTimer: Timer!
    let checkInternetTimeInterval : TimeInterval = 3
    
    let cellId = "repositoryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator()
        attemptFetchData()
    }
    
    // MARK: - Fetch Data Function
    func attemptFetchData() {
        self.activityIndicatorStart()
        
        viewModel.updateLoadingStatus = { let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop() }
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                switch error {
                case .noResponse, .noData:
                    self.showAlert("Problema ao consultar os repositórios, verifique sua conexão com a internet.")
                case .noInternetConnection:
                    self.initInternetConnectionCheck()
                    self.showAlert("Por favor verifique sua conexão com a internet!")
                default:
                    print(error)
                }
            }
        }
        
        viewModel.didFinishFetch = {
            self.repositoriesCellViewModel = self.viewModel.repositoriesCellViewModels
            self.tableView.reloadData()
        }
        
        viewModel.fetchData()
    }
    
    func initInternetConnectionCheck(){
        if checkInternetTimer == nil {
            activityIndicatorStart()
            checkInternetTimer = Timer.scheduledTimer(timeInterval: checkInternetTimeInterval, target: self, selector: #selector(checkInernet), userInfo: nil, repeats: true)
        }
    }
    
    @objc func checkInernet(){
        if CheckInternet.Connection() {
            checkInternetTimer.invalidate()
            checkInternetTimer = nil
            activityIndicatorStop()
            attemptFetchData()
        }
    }
    
    // MARK: - UI Setup
    private func activityIndicatorStart() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    private func activityIndicatorStop() {
        indicator.stopAnimating()
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.center = self.view.center
        
        //indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

//TableViewDataSource extension func
extension RepositoryTableViewController {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesCellViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RepositoryCell else {
            return UITableViewCell()
        }
        
        let repositoryCellViewModel = repositoriesCellViewModel[indexPath.row]
        cell.repositoryCellViewModel = repositoryCellViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let repositoryCellViewModel = repositoriesCellViewModel[indexPath.row]
        
        guard let url = URL(string: repositoryCellViewModel.url) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.repositoriesCellViewModels.count-1 {
            self.attemptFetchData()
        }
    }
    
}
