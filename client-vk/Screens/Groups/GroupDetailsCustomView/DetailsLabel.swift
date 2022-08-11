//
//  DetailsLabel.swift
//  client-vk
//
//  Created by Mac on 8/9/22.
//

import UIKit

class DetailsLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .left
        numberOfLines = 3
        font = .systemFont(ofSize: 18)
    }
}
