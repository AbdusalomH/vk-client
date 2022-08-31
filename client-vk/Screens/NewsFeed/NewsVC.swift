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

final class NewsVC: UIViewController {
    
    var heightImage: CGFloat = 0
    
    var newsFeed: [PostCellModel] = []
    
    
    lazy var newsTableView: UITableView = {
        
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.delegate = self
        tableview.dataSource = self
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        
        tableview.register(AuthorOfFeedTableViewCell.self, forCellReuseIdentifier: AuthorOfFeedTableViewCell.reuseID)
        tableview.register(TextOfFeedTableViewCell.self, forCellReuseIdentifier: TextOfFeedTableViewCell.reuseID)
        tableview.register(PhotoOfFeedTableViewCell.self, forCellReuseIdentifier: PhotoOfFeedTableViewCell.reuseID)
        tableview.register(LikeCountTableViewCell.self, forCellReuseIdentifier: LikeCountTableViewCell.reuseID)
        tableview.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.reuseID)
        return tableview
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureNavigatioBar()
        setupViews()
        setupContraints()
        fetchNews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsTableView.reloadData()
    }
    
//     private func configureNavigatioBar() {
//         let navBarAppearance = UINavigationBarAppearance()
//         navBarAppearance.configureWithOpaqueBackground()
//         navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
//         navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//         navBarAppearance.backgroundColor =  #colorLiteral(red: 0.9502168298, green: 0.9445304871, blue: 0.9708524346, alpha: 1)
//         navigationController?.navigationBar.standardAppearance = navBarAppearance
//         navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
//     }
    
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.9502168298, green: 0.9445304871, blue: 0.9708524346, alpha: 1)
        view.addSubview(newsTableView)
    }

    
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            newsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            newsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func fetchNews() {
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
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    
    
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
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellType = PostCellType(rawValue: indexPath.row)
        let cellnews = newsFeed[indexPath.section]
        
        switch cellType {

        case .text:
                if cellnews.text.isEmpty {
                return CGFloat.zero
            }
        case .photo:
            if cellnews.imageURL.isEmpty {
                return CGFloat.zero
            }
            
        default:
            return UITableView.automaticDimension

        }
        return UITableView.automaticDimension
    }
}


