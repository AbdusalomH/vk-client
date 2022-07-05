//
//  UserInfoVC.swift
//  client-vk
//
//  Created by Mac on 7/4/22.
//

import UIKit
import SDWebImage
import SkeletonView

class UserInfoVC: UIViewController {
    
    var usersInfo: Friend
    
    init(userInfo: Friend) {
        self.usersInfo = userInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isSkeletonShown: Bool = false
    
    let userImage = UIImageView()
    let userFullName = UILabel()
    let location = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = usersInfo.firstName
        view.backgroundColor = .white
        
        configure()
        shoSkeleton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureUsersData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userImage.layer.cornerRadius = 50
        userImage.clipsToBounds = true
    }
    
    private func configure() {
        
        view.addSubview(userImage)
        view.addSubview(userFullName)
        view.addSubview(location)
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userFullName.translatesAutoresizingMaskIntoConstraints = false
        location.translatesAutoresizingMaskIntoConstraints = false
        
        userImage.isSkeletonable = true
        userFullName.isSkeletonable = true
        location.isSkeletonable = true
        
        userFullName.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        location.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = 50
        userImage.clipsToBounds = true
        userImage.image = UIImage(systemName: "person")
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            userImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            userImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            userFullName.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 20),
            userFullName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            userFullName.widthAnchor.constraint(equalTo: view.widthAnchor),
            userFullName.heightAnchor.constraint(equalToConstant: 25),
            
            location.topAnchor.constraint(equalTo: userFullName.bottomAnchor, constant: 16),
            location.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            location.widthAnchor.constraint(equalTo: view.widthAnchor),
            location.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func configureUsersData() {
        if isSkeletonShown == false {
            let url = URL(string: usersInfo.photo200_Orig)
            userImage.stopSkeletonAnimation()
            userImage.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            userFullName.stopSkeletonAnimation()
            userFullName.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            location.stopSkeletonAnimation()
            location.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            
            userImage.sd_setImage(with: url)
            userFullName.text = "\(usersInfo.firstName) \(usersInfo.lastName)"
            
            location.text = usersInfo.city?.title
            
            isSkeletonShown.toggle()
        }
    }
    
    func shoSkeleton() {
        if !isSkeletonShown {
            userImage.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .gray), animation: nil, transition: .crossDissolve(0.2))
            userFullName.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .gray), animation: nil, transition: .crossDissolve(0.2))
            location.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .gray), animation: nil, transition: .crossDissolve(0.2))
            
            isSkeletonShown = false
        }
    }
}
