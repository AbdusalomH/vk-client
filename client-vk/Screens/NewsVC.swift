//
//  NewsVC.swift
//  client-vk
//
//  Created by Mac on 7/11/22.
//

import UIKit

class NewsVC: UIViewController {
    
    
    var newsTableView: UITableView {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"

        view.backgroundColor = .carrot
        let newsService = NewsApi()
        newsService.getNews {  result in
            
            switch result {
            case .success(let posts):
                print(posts)
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
