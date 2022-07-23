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
    

    
    var videosTabelview: UITableView!
    var videos: [VideosItems] = []
    var filteredVideos: [VideosItems] = []
    
    var isAddedToSkeleton: Bool = false
    
    var isReceivingVideoData: Bool = false
 
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Videos"
        configureTabelView()
        configureSearch()
        showSkeleton()
        showVideosData()
    }
    
    func configureSearch() {
        
        let searchVideo = UISearchController()
        searchVideo.searchResultsUpdater = self
        searchVideo.searchBar.delegate = self
        searchVideo.searchBar.placeholder = "Search video"
        searchVideo.becomeFirstResponder()
        
        navigationItem.searchController = searchVideo
        
        
    }

    
    
    func showSkeleton() {
        if isAddedToSkeleton == false {
            self.videosTabelview.isSkeletonable = true
            self.videosTabelview.startSkeletonAnimation()
            self.videosTabelview.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor.gray), animation: nil, transition: .crossDissolve(0.5))
            self.isAddedToSkeleton = true
        }
    }
    
    
    func showVideosData(offSet: Int = 0) {
        
        if isAddedToSkeleton {
            
            let videos = VideosApi()
            videos.getVideos(offset: offSet) { [weak self] result in
                guard let self = self else {return}
                
                self.isReceivingVideoData = false
                
                switch result {
                case .success(let videos):
                    if offSet == 0 {
                        self.videosTabelview.stopSkeletonAnimation()
                        self.videosTabelview.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                        self.videos.append(contentsOf: videos)
                        self.videosTabelview.reloadData()
                        return
                    }
                    
                    self.videos.append(contentsOf: videos)
                    self.videosTabelview.reloadData()
                    
                case .failure(let error):
                    print(error)
                    
                }
            }
        }
    }
    
    func configureTabelView() {
        
        videosTabelview = UITableView()
        
        view.addSubview(videosTabelview)
        
        videosTabelview.register(VideoCell.self, forCellReuseIdentifier: VideoCell.reuseID)
        
        videosTabelview.translatesAutoresizingMaskIntoConstraints = false
        
        videosTabelview.delegate = self
        videosTabelview.dataSource = self
        videosTabelview.prefetchDataSource = self
        
        videosTabelview.estimatedRowHeight = 150
        
        NSLayoutConstraint.activate([
        
            videosTabelview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videosTabelview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            videosTabelview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            videosTabelview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
    
    
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
//        print(videoURL)
//
//        guard let url = URL(string: videoURL) else {return}
//
//        let playerVC = AVPlayerViewController()
//        let player = AVPlayer(url: url)
//        playerVC.player = player
//
//
//        present(playerVC, animated: true) {
//            playerVC.player?.play()
//        }
        
        
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
            showVideosData(offSet: videosCount)
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

