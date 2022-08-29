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
    
    let backview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let friendImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
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
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        backview.layer.cornerRadius = 15
        backview.clipsToBounds = true
        
        friendImage.layer.cornerRadius = 40
        friendImage.contentMode = .scaleAspectFit
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
    }
    
    
    func configure(_ friend: Friend) {
        nameLabel.text = friend.firstName
        guard let imageURL = URL(string: friend.photo100) else {return}
        friendImage.sd_setImage(with: imageURL)
    }

    
    
    func setupViews() {
        contentView.addSubview(backview)
        contentView.addSubview(friendImage)
        contentView.addSubview(nameLabel)
        
        contentView.isSkeletonable  = true
        friendImage.isSkeletonable  = true
        nameLabel.isSkeletonable    = true
        
    }
    
    func setupContraints() {
        
        NSLayoutConstraint.activate([
            
            backview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            backview.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            backview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            backview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            
            friendImage.topAnchor.constraint(equalTo: backview.topAnchor, constant: 20),
            friendImage.leadingAnchor.constraint(equalTo: backview.leadingAnchor, constant: 20),
            friendImage.bottomAnchor.constraint(equalTo: backview.bottomAnchor, constant: -20),
            friendImage.heightAnchor.constraint(equalToConstant: 80),
            friendImage.widthAnchor.constraint(equalToConstant: 80),
   
            
            nameLabel.leadingAnchor.constraint(equalTo: friendImage.trailingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: backview.topAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: backview.trailingAnchor, constant: -20),
            nameLabel.bottomAnchor.constraint(equalTo: backview.bottomAnchor, constant: -20),
        ])  
    }
}
