//
//  RepositoryCell.swift
//  GithubMostPopular
//
//  Created by Garcia, Bruno (B.C.) on 03/05/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {

    
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblStar: UILabel!
    @IBOutlet weak var lblFork: UILabel!
    
    
    var repositoryCellViewModel : RepositoryCellViewModel! {
        didSet {
            lblName.text = repositoryCellViewModel.fullName
            lblDescription.text = repositoryCellViewModel.description
            lblStar.text = formatNumber(repositoryCellViewModel.stars)
            ivAvatar.loadImageUsingUrlString(urlString: repositoryCellViewModel.userAvatarUrl)
            lblFork.text = formatNumber(repositoryCellViewModel.forks)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
