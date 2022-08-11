//
//  DetailsImageView.swift
//  client-vk
//
//  Created by Mac on 8/9/22.
//

import UIKit
import SDWebImage

class DetailsImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit

    }
}
