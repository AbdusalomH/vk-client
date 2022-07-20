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
    
    let authorNameLabel = UILabel()
    let authorImageView = UIImageView()
    let postDate = UILabel()

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
        authorImageView.layer.cornerRadius = 0.5 * authorImageView.frame.height
    }
    
    
    func configure() {
        
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(authorImageView)
        contentView.addSubview(postDate)
                        
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorImageView.translatesAutoresizingMaskIntoConstraints = false
        postDate.translatesAutoresizingMaskIntoConstraints = false
        
        authorNameLabel.numberOfLines = 3
        authorNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        authorImageView.contentMode = .scaleAspectFill
        
        
        postDate.font = UIFont.systemFont(ofSize: 12, weight: .light)
        postDate.textAlignment = .left
        
        let marginConterView = contentView.layoutMarginsGuide
        
        
        NSLayoutConstraint.activate([
            
            authorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            authorImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            authorImageView.widthAnchor.constraint(equalToConstant: 50),
            

            
//            marginConterView.topAnchor.constraint(equalTo: authorImageView.topAnchor, constant: -16),
//            marginConterView.leadingAnchor.constraint(equalTo: authorImageView.leadingAnchor, constant: 8),
//            marginConterView.bottomAnchor.constraint(equalTo: authorImageView.bottomAnchor, constant: 8),
//            authorImageView.widthAnchor.constraint(equalToConstant: 50),
            
//            marginConterView.trailingAnchor.constraint(equalTo: postDate.trailingAnchor, constant: -8),
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
