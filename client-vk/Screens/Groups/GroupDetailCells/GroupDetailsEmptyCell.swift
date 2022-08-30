//
//  EmptyCell.swift
//  client-vk
//
//  Created by Mac on 8/29/22.
//

import UIKit

class GroupEmptyCell: UITableViewCell {

    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        contentView.addSubview(emptyLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            emptyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            emptyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            emptyLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            emptyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            emptyLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
