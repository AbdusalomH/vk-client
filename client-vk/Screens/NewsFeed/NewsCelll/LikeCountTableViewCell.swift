//
//  LikeCountTableViewCell.swift
//  client-vk
//
//  Created by Mac on 7/18/22.
//

import UIKit

class LikeCountTableViewCell: UITableViewCell {
    
    static let reuseID = "likeCell"
    
    let likeImage = UIImageView()
    let countLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 15
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.clipsToBounds = true
    }
    
    
    func config(likeCounts: Int) {
   
        if likeCounts > 0 {
            likeImage.image = UIImage(systemName: "heart.fill")
            likeImage.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            countLabel.text = "\(likeCounts)"
        } else {
            likeImage.image = UIImage(systemName: "heart")
            likeImage.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            countLabel.text = "\(likeCounts)"
        }
    }
    
    
    func configure() {
        
        contentView.addSubview(likeImage)
        contentView.addSubview(countLabel)
        
        likeImage.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.layer.cornerRadius = 12
        
        likeImage.image = UIImage(systemName: "suit.heart.fill")
        
        NSLayoutConstraint.activate([
        
            likeImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            likeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            likeImage.heightAnchor.constraint(equalToConstant: 30),
            likeImage.widthAnchor.constraint(equalToConstant: 30),
            
            countLabel.leadingAnchor.constraint(equalTo: likeImage.trailingAnchor, constant: 10),
            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            countLabel.heightAnchor.constraint(equalToConstant: 30),
            countLabel.widthAnchor.constraint(equalToConstant: 100)
            
        
        ])
    }
}
