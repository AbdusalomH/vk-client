//
//  PhotoOfFeedTableViewCell.swift
//  client-vk
//
//  Created by Mac on 7/18/22.
//

import UIKit
import SDWebImage

class PhotoOfFeedTableViewCell: UITableViewCell {
    
    static let reuseID = "photoCell"
    
    
    let postImage = ScaledHeightImageView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func config(imageName: String) {
        guard let url = URL(string: imageName) else {return}
        
        postImage.sd_setImage(with: url)
    }

    func configure() {
        contentView.addSubview(postImage)
        
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.clipsToBounds = true
        

        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
