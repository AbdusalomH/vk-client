//
//  MainTabBarVC.swift
//  client-vk
//
//  Created by Mac on 6/28/22.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        let friends = FriendVC()
        
        let friendsTabBarItem = UITabBarItem()
        
        friendsTabBarItem.title = "Друзья"
        friendsTabBarItem.image = UIImage(systemName: "person")
        friends.tabBarItem = friendsTabBarItem
        
        
        let groups = GroupsVC()
        
        let groupsBarItem = UITabBarItem()
        groupsBarItem.title = "Группа"
        groupsBarItem.image = UIImage(systemName: "person.3")
        groups.tabBarItem = groupsBarItem
        
        
        let navigationFiendsVC = UINavigationController(rootViewController: friends)
        let navigationGroupsVC = UINavigationController(rootViewController: groups)
        
        self.viewControllers = [navigationFiendsVC, navigationGroupsVC]
        
    }

}
