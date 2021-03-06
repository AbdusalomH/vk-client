//
//  NewsVC.swift
//  client-vk
//
//  Created by Mac on 7/11/22.
//

import UIKit


enum PostCellType: Int, CaseIterable {
    
    case author = 0
    case text
    case photo
    case likeCount
    case empty
    
}

class NewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var heightImage: CGFloat = 0
    
    var newsTableView: UITableView!
    
    var newsFeed: [PostCellModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        configureNavigatioBar()
        configureTableView()
                
        view.backgroundColor = #colorLiteral(red: 0.9502168298, green: 0.9445304871, blue: 0.9708524346, alpha: 1)
        let newsService = NewsApi()
        newsService.getNews { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.newsFeed = posts
                    self.newsTableView.reloadData()
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func configureNavigatioBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor =  #colorLiteral(red: 0.9502168298, green: 0.9445304871, blue: 0.9708524346, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    
    private func configureTableView() {
        
        newsTableView = UITableView()
        view.addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        newsTableView.showsVerticalScrollIndicator = false
        //newsTableView.backgroundColor = .white
        
        newsTableView.register(AuthorOfFeedTableViewCell.self, forCellReuseIdentifier: AuthorOfFeedTableViewCell.reuseID)
        newsTableView.register(TextOfFeedTableViewCell.self, forCellReuseIdentifier: TextOfFeedTableViewCell.reuseID)
        newsTableView.register(PhotoOfFeedTableViewCell.self, forCellReuseIdentifier: PhotoOfFeedTableViewCell.reuseID)
        newsTableView.register(LikeCountTableViewCell.self, forCellReuseIdentifier: LikeCountTableViewCell.reuseID)
        newsTableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.reuseID)
        
        newsTableView.estimatedRowHeight = UITableView.automaticDimension
        newsTableView.cellLayoutMarginsFollowReadableWidth = true
        
        //newsTableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
        
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            newsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            newsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsFeed.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostCellType.allCases.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = newsFeed[indexPath.section]
        let postCellType = PostCellType(rawValue: indexPath.row)
        
        switch postCellType {
            
        case .author:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AuthorOfFeedTableViewCell.reuseID, for: indexPath) as! AuthorOfFeedTableViewCell
            
            cell.config(authorName: item.authorName, authorPhoto: item.authorImageURL, dateOfPublication: Date())
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            cell.layer.cornerRadius = 5
            
            return cell

        case .text:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TextOfFeedTableViewCell.reuseID, for: indexPath) as! TextOfFeedTableViewCell
            
            cell.config(text: item.text)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)

            return cell

        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoOfFeedTableViewCell.reuseID, for: indexPath) as! PhotoOfFeedTableViewCell
            
            cell.config(imageName: item.imageURL)          
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)

            return cell

        case .likeCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: LikeCountTableViewCell.reuseID, for: indexPath) as! LikeCountTableViewCell
            
            cell.config(likeCounts: item.likesCount)
            cell.layer.cornerRadius = 20
                        
            return cell
            
        case .empty:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.reuseID, for: indexPath) as! EmptyTableViewCell
            
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


