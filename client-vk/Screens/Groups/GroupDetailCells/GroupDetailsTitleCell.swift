//
//  GroupDetailsCell.swift
//  client-vk
//
//  Created by Mac on 8/9/22.
//

import UIKit


class GroupDetailsTitleCell: UITableViewCell {
    
    
    static let reuseID = "titleCell"
    
    lazy var postTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraint()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String) {
        postTitle.text = title
    }
    
    
    func setupViews() {
        contentView.addSubview(postTitle)
    }
    
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            postTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
    }
}
