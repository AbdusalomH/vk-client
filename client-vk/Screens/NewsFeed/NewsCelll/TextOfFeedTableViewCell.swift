//
//  TextOfFeedTableViewCell.swift
//  client-vk
//
//  Created by Mac on 7/18/22.
//

import UIKit

class TextOfFeedTableViewCell: UITableViewCell {
    
    
    static let reuseID = "textCell"
    
    
    let textOfNews = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(text: String) {
        textOfNews.text = text
    }
    
    
    func configure() {
        contentView.addSubview(textOfNews)
        textOfNews.translatesAutoresizingMaskIntoConstraints = false
        
        textOfNews.textAlignment = .left
        textOfNews.numberOfLines = 0
        textOfNews.font = UIFont.systemFont(ofSize: 16)
        
        NSLayoutConstraint.activate([
        
            textOfNews.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textOfNews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            textOfNews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            textOfNews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8)
        
        ])
    }
}
