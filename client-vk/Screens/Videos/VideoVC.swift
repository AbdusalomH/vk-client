//
//  VideoVC.swift
//  client-vk
//
//  Created by Mac on 7/20/22.
//

import UIKit
import SkeletonView
import AVKit
import AVFoundation


class VideoVC: UIViewController, UITableViewDelegate, SkeletonTableViewDataSource {
    
    var videos: [VideosItems] = []
    var filteredVideos: [VideosItems] = []
    
    var isAddedToSkeleton: Bool = false
    
    var isReceivingVideoData: Bool = false

    
    lazy var videosTabelview: UITableView = {
        
        let tableview = UITableView()
        tableview.register(VideoCell.self, forCellReuseIdentifier: VideoCell.reuseID)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.delegate = self
        tableview.dataSource = self
        tableview.prefetchDataSource = self
        tableview.estimatedRowHeight = 150
        return tableview
    }()
    
    lazy var searchVideo:  UISearchController = {
        let search = UISearchController()
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Search video"
        search.becomeFirstResponder()
        return search
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContraints()
        setupSkeleton()
        fetchVideos(offSet: 0)
        
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = "Videos"
        navigationItem.searchController = searchVideo
        view.addSubview(videosTabelview)
    }
    
    private func setupContraints() {
        videosTabelview.pinToEdges(to: view)
    }

    
    private func setupSkeleton() {
        if isAddedToSkeleton == false {
            self.videosTabelview.isSkeletonable = true
            self.videosTabelview.startSkeletonAnimation()
            self.videosTabelview.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor.gray), animation: nil, transition: .crossDissolve(0.5))
            self.isAddedToSkeleton = true
        }
    }
    
    private func fetchVideos2(offSet: Int = 0, success: @escaping ()->(), failure: @escaping (Error) -> ()) {
        
        Api.request(endpoint: VideosEndpoint.fetchVideos(offset: offSet), responseModel: VideosResponse.self) { result in
            
            switch result {
            case .success(let revievedvideo):
                if offSet == 0 {
                    self.videosTabelview.stopSkeletonAnimation()
                    self.videosTabelview.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                    self.videos = revievedvideo.items
                    self.videosTabelview.reloadData()
                    success()
                    return
                }
                self.videos.append(contentsOf: revievedvideo.items)
                self.videosTabelview.reloadData()
                
            case .failure(let error):
                failure(error)
                print(error)
            }
        }
    }
    
    
    func fetchVideos(offSet: Int = 0) {
        
        if isAddedToSkeleton {
            fetchVideos2(offSet: offSet) {
                self.videosTabelview.stopSkeletonAnimation()
                self.videosTabelview.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                self.videosTabelview.reloadData()
            } failure: { error in
                print(error)
            }
        }
    }
            
            
//
//            let videos = VideosApi()
//            videos.getVideos(offset: offSet) { [weak self] result in
//                guard let self = self else {return}
//
//                self.isReceivingVideoData = false
//
//                switch result {
//                case .success(let videos):
//                    if offSet == 0 {
//
//                        return
//                    }
//
//                    self.videos.append(contentsOf: videos)
//                    self.videosTabelview.reloadData()
//
//                case .failure(let error):
//                    print(error)
//
//                }
//            }
//        }

    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredVideos.isEmpty {
            return filteredVideos.count
        }
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.reuseID, for: indexPath) as! VideoCell
  
        if !filteredVideos.isEmpty {
            
            let filteredVideo = filteredVideos[indexPath.row]
            let filtervideoDuration = filteredVideo.duration ?? 0
            let (h,m,s) = secondsToHoursMinutesSeconds(filtervideoDuration)
            let imageQuality = filteredVideo.image[2].url
            cell.configData(title: filteredVideo.title ?? "", imageName: imageQuality ?? "", videohours: h, videoMinutes: m, videoSeconds: s)
            
        } else {
            let video = videos[indexPath.row]
            let videoDuration = video.duration ?? 0
            let (h,m,s) = secondsToHoursMinutesSeconds(videoDuration)
            let imageQuality = video.image[2].url
            cell.configData(title: video.title ?? "", imageName: imageQuality ?? "", videohours: h, videoMinutes: m, videoSeconds: s)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let videoURL = videos[indexPath.row].player else {return}
        let playVC = VideoDetailsVC(videolUrl: videoURL)
        navigationController?.pushViewController(playVC, animated: true)
    }
    
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
       return VideoCell.reuseID
        
    }
}

extension VideoVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
                
        let videosCount = indexPaths.map({$0.last ?? 0}).max() ?? 0
        
        if videosCount > videos.count - 7, !isReceivingVideoData {
            isReceivingVideoData = true
            fetchVideos(offSet: videosCount)
        }
    } 
}


extension VideoVC: UISearchResultsUpdating, UISearchBarDelegate  {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text, !text.isEmpty else {return}
        
        filteredVideos = videos.filter({$0.title!.lowercased().contains(text.lowercased())})
        videosTabelview.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredVideos.removeAll()
        videosTabelview.reloadData()
    }  
}

