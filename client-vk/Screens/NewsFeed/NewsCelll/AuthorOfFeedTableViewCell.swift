//
//  AuthorOfFeedTableViewCell.swift
//  client-vk
//
//  Created by Mac on 7/18/22.
//

import UIKit
import SDWebImage

class AuthorOfFeedTableViewCell: UITableViewCell {
    
    static let reuseID = "cell"
    
    lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    
    lazy var authorImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
    lazy var postDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(authorName: String, authorPhoto: String, dateOfPublication: Date) {
            authorNameLabel.text = authorName
            guard let url = URL(string: authorPhoto) else {return}
            authorImageView.sd_setImage(with: url)
            
            postDate.text = "\(dateOfPublication.formatted(date: .omitted, time: .shortened))"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 15
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.clipsToBounds = true
        
    }


    
    func configure() {
        
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(authorImageView)
        contentView.addSubview(postDate)
                        
        NSLayoutConstraint.activate([
            
            authorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            authorImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            authorImageView.widthAnchor.constraint(equalToConstant: 50),
            
            postDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            postDate.centerYAnchor.constraint(equalTo: authorImageView.centerYAnchor),
            postDate.heightAnchor.constraint(equalToConstant: 20),
            postDate.widthAnchor.constraint(equalToConstant: 50),
            
            authorNameLabel.centerYAnchor.constraint(equalTo: authorImageView.centerYAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 20),
            authorNameLabel.trailingAnchor.constraint(equalTo: postDate.leadingAnchor, constant: -20),
            authorImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
