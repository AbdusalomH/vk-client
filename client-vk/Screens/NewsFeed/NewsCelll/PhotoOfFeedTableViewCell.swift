//
//  PhotoOfFeedTableViewCell.swift
//  client-vk
//
//  Created by Mac on 7/18/22.
//

import UIKit
import SDWebImage
import Kingfisher

class PhotoOfFeedTableViewCell: UITableViewCell {
    
    static let reuseID = "photoCell"
    
    
    lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func config(imageName: String) {
        guard let url = URL(string: imageName) else {return}
        


        postImage.kf.indicatorType = .activity
        postImage.kf.setImage(with: url)
    }


    }
    
    private func setupViews() {
        contentView.addSubview(postImage)
    }

    func setupContraints() {
   
        NSLayoutConstraint.activate([
            postImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1),
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            postImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        ])
    }
}
