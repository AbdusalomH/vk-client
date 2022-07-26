//
//  VideoCell.swift
//  client-vk
//
//  Created by Mac on 7/20/22.
//

import UIKit
import SDWebImage
import SkeletonView

class VideoCell: UITableViewCell {
    
    static let reuseID = "videoCell"
    
    let videoTitle = UILabel()
    let videImage = ScaledHeightImageView()
    let playButton = UIImageView()
    let duration = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configData(title: String, imageName: String, videohours: Int, videoMinutes: Int, videoSeconds: Int) {
        videoTitle.text = title
        let imageUrl = URL(string: imageName)
        videImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "screen"))
        
        duration.text = "\(videohours.addZero()) : \(videoMinutes.addZero()) : \(videoSeconds.addZero())"
    }
    
    func configure() {
        
        contentView.addSubview(videImage)
        videImage.addSubview(videoTitle)
        videImage.addSubview(playButton)
        videImage.addSubview(duration)
        
        //videoTitle.isSkeletonable = true
        videImage.isSkeletonable = true
        

        //playButton.isSkeletonable = true
        
        videoTitle.translatesAutoresizingMaskIntoConstraints = false
        videImage.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        duration.translatesAutoresizingMaskIntoConstraints = false

        playButton.image = UIImage(systemName: "livephoto.play")
        playButton.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        videoTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        duration.textColor = .white
        duration.textAlignment = .right
        
        //videImage.contentMode = .scaleAspectFit
        

        NSLayoutConstraint.activate([
            
            videImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            videImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            videImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            videImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            playButton.leadingAnchor.constraint(equalTo: videImage.leadingAnchor, constant: 8),
            playButton.bottomAnchor.constraint(equalTo: videImage.bottomAnchor, constant: -8),
            playButton.heightAnchor.constraint(equalToConstant: 30),
            playButton.widthAnchor.constraint(equalToConstant: 30),
            
            videoTitle.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 10),
            videoTitle.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            videoTitle.trailingAnchor.constraint(equalTo: videImage.trailingAnchor),
            videoTitle.heightAnchor.constraint(equalToConstant: 30),
            
            duration.trailingAnchor.constraint(equalTo: videImage.trailingAnchor, constant: -8),
            duration.topAnchor.constraint(equalTo: videImage.topAnchor, constant: 8),
            duration.heightAnchor.constraint(equalToConstant: 20),
            duration.widthAnchor.constraint(equalToConstant: 120)
   
        ])
    }
}
