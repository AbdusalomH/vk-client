//
//  GroupsCell.swift
//  client-vk
//
//  Created by Mac on 7/4/22.
//

import UIKit
import SDWebImage
import SkeletonView

class GroupsCell: UITableViewCell {
    
    let groupsImage = UIImageView()
    let groupsName = UILabel()
    
    static let reuseID = "groupCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell(_ group: Group) {
        
        groupsName.text = group.name
        
        guard let url = URL(string: group.photo100) else {return}
        groupsImage.sd_setImage(with: url)
        
    }
    
    
    private func configure() {
        
        contentView.addSubview(groupsImage)
        contentView.addSubview(groupsName)
        
        groupsName.isSkeletonable = true
        groupsImage.isSkeletonable = true
        
        groupsImage.translatesAutoresizingMaskIntoConstraints = false
        groupsName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            groupsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            groupsImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            groupsImage.heightAnchor.constraint(equalToConstant: 50),
            groupsImage.widthAnchor.constraint(equalToConstant: 50),
            
            
            groupsName.leftAnchor.constraint(equalTo: groupsImage.rightAnchor, constant: 10),
            groupsName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            groupsName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            groupsName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
    }
}
