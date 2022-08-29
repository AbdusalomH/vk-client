//
//  GroupDetailsImageCell.swift
//  client-vk
//
//  Created by Mac on 8/9/22.
//

import UIKit

class GroupDetailsImageCell: UITableViewCell {
    
    static let reuseID = "imageCell"
    
    let image = ScaledHeightImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        contentView.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
