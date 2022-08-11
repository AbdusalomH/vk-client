//
//  GroupDetailsCell.swift
//  client-vk
//
//  Created by Mac on 8/9/22.
//

import UIKit
import SDWebImage

class GroupDetailsTitleCell: UITableViewCell {
    
    
    static let reuseID = "titleCell"
    
    let postTitle = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String) {
        postTitle.text = title
    }
    
    
    func configure() {
        contentView.addSubview(postTitle)
        postTitle.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            postTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
