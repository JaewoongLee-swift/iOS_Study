//
//  RepositoryListCell.swift
//  GithubRepository
//
//  Created by 이재웅 on 2022/01/07.
//

import UIKit
import SnapKit

class RepositoryListCell: UITableViewCell {
    var repository: String?
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let starImageView = UIImageView()
    let starLabel = UILabel()
    let languageLabel = UILabel()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [
            nameLabel, descriptionLabel, starImageView, starLabel, languageLabel
        ].forEach{
            contentView.addSubview($0)
        }
    }
}
