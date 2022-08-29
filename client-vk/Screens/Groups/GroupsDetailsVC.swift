//
//  GroupsDetailsVC.swift
//  client-vk
//
//  Created by Mac on 7/15/22.
//

import UIKit
import SDWebImage
import Kingfisher

enum GroupsDetailsEnum: Int, CaseIterable {
    case title = 0
    case photo
}

class GroupsDetailsVC: UIViewController {
    
    var groupTitle: String
    var groupImage: String
    var groupID: Int
    
    init(title: String, image: String, id: Int) {
        groupTitle = title
        groupImage = image
        groupID = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let groupLabel = DetailsLabel()
    let groupImageSelected = DetailsImageView(frame: .zero)
    
    
    lazy var detailsTabel: UITableView = {
        let tabel = UITableView()

        tabel.translatesAutoresizingMaskIntoConstraints = false
        tabel.delegate = self
        tabel.dataSource = self
        tabel.register(GroupDetailsTitleCell.self, forCellReuseIdentifier: GroupDetailsTitleCell.reuseID)
        tabel.register(GroupDetailsImageCell.self, forCellReuseIdentifier: GroupDetailsImageCell.reuseID)
        tabel.separatorStyle = .none
        return tabel
    }()
    
    var groupDetailsData: [ResponseItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupContraints()
        fetchGroupDetails()
        
    }
    
    override func viewDidLayoutSubviews() {
        groupImageSelected.layer.cornerRadius = 30
        groupImageSelected.clipsToBounds = true
    }
    
    func setupViews() {
        
        title = groupTitle
        view.backgroundColor = .systemBackground
        view.addSubview(groupImageSelected)
        view.addSubview(groupLabel)
        view.addSubview(detailsTabel)
        
        
        guard let url = URL(string: groupImage) else {return}
        groupImageSelected.sd_setImage(with: url)
        groupLabel.text = groupTitle
        groupLabel.numberOfLines = 0
        groupLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setupContraints() {
        
        NSLayoutConstraint.activate([
        
            groupImageSelected.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            groupImageSelected.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            groupImageSelected.heightAnchor.constraint(equalToConstant: 60),
            groupImageSelected.widthAnchor.constraint(equalToConstant: 60),
            
            groupLabel.leadingAnchor.constraint(equalTo: groupImageSelected.trailingAnchor, constant: 20),
            groupLabel.centerYAnchor.constraint(equalTo: groupImageSelected.centerYAnchor),
            groupLabel.heightAnchor.constraint(equalToConstant: 50),
            groupLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            detailsTabel.topAnchor.constraint(equalTo: groupImageSelected.bottomAnchor, constant: 20),
            detailsTabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailsTabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailsTabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)

        ])
    }
    
    func fetchGroupDetails() {
        
        let groupDetail = GroupDetailsApi()
        
        groupDetail.fetchGroupDetail(groupDetailsID: groupID) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let details):
                self.groupDetailsData = details
                self.detailsTabel.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension GroupsDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return groupDetailsData.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return GroupsDetailsEnum.allCases.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let details = groupDetailsData[indexPath.section]
        let attach = details.attachments?.first?.photo?.sizes?[1].url ?? ""
        let postCell = GroupsDetailsEnum(rawValue: indexPath.row)
        
        switch postCell {
            
        case .title:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: GroupDetailsTitleCell.reuseID, for: indexPath) as! GroupDetailsTitleCell
            
            cell.setup(title: details.text ?? "")
            
            return cell
            
        case .photo:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: GroupDetailsImageCell.reuseID, for: indexPath) as! GroupDetailsImageCell
            
            let url = URL(string: attach)
            //cell.image.sd_setImage(with: url)
            
            cell.image.kf.indicatorType = .activity
            cell.image.kf.setImage(with: url)
            
            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let groupDetail = GroupsDetailsEnum(rawValue: indexPath.row)
        let celldetails = groupDetailsData[indexPath.section]
        
        
        switch groupDetail {
            
        case .photo:
            if celldetails.attachments == nil {
                return CGFloat.zero
            }
        default:
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
}
