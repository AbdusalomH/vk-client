//
//  GroupsDetailsVC.swift
//  client-vk
//
//  Created by Mac on 7/15/22.
//

import UIKit
import SDWebImage

class GroupsDetailsVC: UIViewController {
    
    var groupTitle: String
    var groupImage: String
    
    init(title: String, image: String) {
        groupTitle = title
        groupImage = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let groupLable = UILabel()
    let groupImageSelected = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = groupTitle
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    func configureUI() {
        
        view.addSubview(groupImageSelected)
        view.addSubview(groupLable)
        groupLable.translatesAutoresizingMaskIntoConstraints = false
        groupImageSelected.translatesAutoresizingMaskIntoConstraints = false
        
        guard let url = URL(string: groupImage) else {return}
        
        groupImageSelected.sd_setImage(with: url)
        groupLable.text = groupTitle
        groupLable.textAlignment = .center
        groupLable.numberOfLines = 2
                
        NSLayoutConstraint.activate([
            
            groupLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            groupLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            groupLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            groupLable.heightAnchor.constraint(equalToConstant: 50),
        
            groupImageSelected.topAnchor.constraint(equalTo: groupLable.bottomAnchor, constant: 20),
            groupImageSelected.heightAnchor.constraint(equalToConstant: 150),
            groupImageSelected.widthAnchor.constraint(equalToConstant: 150),
            groupImageSelected.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
