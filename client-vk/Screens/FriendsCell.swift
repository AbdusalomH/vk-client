//
//  FriendsCell.swift
//  client-vk
//
//  Created by Mac on 6/28/22.
//

import UIKit
import SDWebImage
import SkeletonView


class FriendsCell: UITableViewCell {
    
    static let reuseID = "FriendsCell"
    
    let friendImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupContraints()
        isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(_ friend: Friend) {
        nameLabel.text = friend.firstName
        let imageURL = URL(string: friend.photo100)
        friendImage.sd_setImage(with: imageURL)
    }
    
    
    func setupViews() {
        
        contentView.addSubview(friendImage)
        contentView.addSubview(nameLabel)
        
        contentView.isSkeletonable  = true
        friendImage.isSkeletonable  = true
        nameLabel.isSkeletonable    = true

    }
    
    func setupContraints() {
        
        NSLayoutConstraint.activate([
            friendImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            friendImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            friendImage.heightAnchor.constraint(equalToConstant: 50),
            friendImage.widthAnchor.constraint(equalToConstant: 50),
   
            nameLabel.leadingAnchor.constraint(equalTo: friendImage.trailingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])  
    }
}
