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
    
    let backView: UIView = {
        let backview = UIView()
        backview.translatesAutoresizingMaskIntoConstraints = false
        backview.backgroundColor = .white
        return backview
        
    }()
    
    let groupsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let groupsName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    
    static let reuseID = "groupCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstrainst()
        isSkeletonable = true
        groupsName.isSkeletonable = true
        groupsImage.isSkeletonable = true
        backView.isSkeletonable = true
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ group: Group) {
        
        groupsName.text = group.name
        
        guard let url = URL(string: group.photo100) else {return}
        groupsImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
        groupsImage.sd_setImage(with: url)
        
    }
    
    
    private func setupViews() {
        contentView.addSubview(backView)
        contentView.addSubview(groupsImage)
        contentView.addSubview(groupsName)
        
    }
    
    override func layoutSubviews() {
        
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        backView.layer.cornerRadius = 20
        backView.clipsToBounds = true
        
        groupsImage.layer.cornerRadius = 40
        groupsImage.clipsToBounds = true
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        
        
    }
    
    func setupConstrainst() {
        
        NSLayoutConstraint.activate([
            
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
        
            groupsImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            groupsImage.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10),
            groupsImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            groupsImage.heightAnchor.constraint(equalToConstant: 80),
            groupsImage.widthAnchor.constraint(equalToConstant: 80),
            
            
            groupsName.leadingAnchor.constraint(equalTo: groupsImage.trailingAnchor, constant: 10),
            groupsName.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            groupsName.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            groupsName.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10)
        ])
    }
}
