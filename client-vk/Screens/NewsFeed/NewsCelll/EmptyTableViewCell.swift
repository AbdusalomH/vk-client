//
//  EmptyTableViewCell.swift
//  client-vk
//
//  Created by Mac on 7/19/22.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    static let reuseID = "empty"
    
    let heightLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = #colorLiteral(red: 0.9502168298, green: 0.9445304871, blue: 0.9708524346, alpha: 1)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.addSubview(heightLabel)
        
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        heightLabel.backgroundColor = #colorLiteral(red: 0.9502168298, green: 0.9445304871, blue: 0.9708524346, alpha: 1)
        
        NSLayoutConstraint.activate([
            
            heightLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            heightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            heightLabel.topAnchor.constraint(equalTo: self.topAnchor),
            heightLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            heightLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
