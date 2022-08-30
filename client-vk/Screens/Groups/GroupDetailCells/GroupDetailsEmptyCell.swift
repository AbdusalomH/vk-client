//
//  EmptyCell.swift
//  client-vk
//
//  Created by Mac on 8/29/22.
//

import UIKit

class GroupDetailsEmptyCell: UITableViewCell {
    
    static let reuseID = "GroupDetailsEmptyCell"

    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
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
        self.addSubview(emptyLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            emptyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            emptyLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            emptyLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            emptyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            emptyLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
