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
        
        
        let news = NewsVC()
        let newsBarItem = UITabBarItem()
        newsBarItem.title = "Новости"
        newsBarItem.image = UIImage(systemName: "globe.americas")
        news.tabBarItem = newsBarItem
        
        let group2 = GroupsWithPresenter()
        let groupWithPresenter = UITabBarItem()
        groupWithPresenter.title =  "Группы2"
        groupWithPresenter.image = UIImage(systemName: "person.2.wave.2")
        group2.tabBarItem = groupWithPresenter
        
        
        let videos = VideoVC()
        let videoBarItem = UITabBarItem()
        videoBarItem.title = "Videos"
        videoBarItem.image = UIImage(systemName: "video.square")
        videos.tabBarItem = videoBarItem
        
        
        
        let navigationFiendsVC = UINavigationController(rootViewController: friends)
        let navigationGroupsVC = UINavigationController(rootViewController: groups)
        let navigationNewsVC = UINavigationController(rootViewController: news)
        let navigationGroup2VC = UINavigationController(rootViewController: group2)
        let navigationVideos = UINavigationController(rootViewController: videos)
        
        self.viewControllers = [navigationFiendsVC, navigationNewsVC, navigationGroupsVC,navigationGroup2VC, navigationVideos]
        
    }

}
