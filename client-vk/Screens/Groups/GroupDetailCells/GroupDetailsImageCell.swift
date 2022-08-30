//
//  GroupDetailsImageCell.swift
//  client-vk
//
//  Created by Mac on 8/9/22.
//

import UIKit

class GroupDetailsImageCell: UITableViewCell {
    
    static let reuseID = "imageCell"
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupContraints()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(image)
    }
    
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1),
            image.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
