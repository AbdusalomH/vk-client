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
    
    lazy var backview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var videoTitle: UILabel = {
        let videoTitle = UILabel()
        videoTitle.translatesAutoresizingMaskIntoConstraints = false
        videoTitle.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        return videoTitle
    }()
    
    
    lazy var videoImage: UIImageView = {
        let videoImage = UIImageView()
        videoImage.translatesAutoresizingMaskIntoConstraints = false
        videoImage.contentMode = UIView.ContentMode.scaleAspectFit
        return videoImage
    }()
    
    lazy var playButton: UIImageView = {
        let playButton = UIImageView()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.image = UIImage(systemName: "livephoto.play")
        playButton.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return playButton
    }()
    
    let duration: UILabel = {
        let duration = UILabel()
        duration.translatesAutoresizingMaskIntoConstraints = false
        duration.textColor = .white
        duration.textAlignment = .right
        duration.backgroundColor = .black
        duration.textAlignment = .center
        return duration
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraint()
        isSkeletonable = true
        
    }
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        duration.layer.cornerRadius = 8
        duration.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configData(title: String, imageName: String, videohours: Int, videoMinutes: Int, videoSeconds: Int) {
        videoTitle.text = title
        let imageUrl = URL(string: imageName)
        videoImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "screen"))
        
        duration.text = " \(videohours.addZero()) : \(videoMinutes.addZero()) : \(videoSeconds.addZero()) "
    }
    

    func setupViews() {
        contentView.addSubview(backview)
        contentView.addSubview(videoImage)
        contentView.addSubview(videoTitle)
        contentView.addSubview(playButton)
        contentView.addSubview(duration)
        videoImage.isSkeletonable = true
    }
    
    private func setupConstraint() {


        NSLayoutConstraint.activate([
            
            backview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            backview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            backview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            videoImage.heightAnchor.constraint(equalTo: backview.heightAnchor, multiplier: 1),
            videoImage.widthAnchor.constraint(equalTo: backview.heightAnchor, multiplier: 1),
            videoImage.topAnchor.constraint(equalTo: backview.topAnchor, constant: 0),
            videoImage.leadingAnchor.constraint(equalTo: backview.leadingAnchor, constant: 0),
            videoImage.trailingAnchor.constraint(equalTo: backview.trailingAnchor, constant: 0),
            videoImage.bottomAnchor.constraint(equalTo: backview.bottomAnchor, constant: 0),
            
            playButton.leadingAnchor.constraint(equalTo: videoImage.leadingAnchor, constant: 8),
            playButton.bottomAnchor.constraint(equalTo: videoImage.bottomAnchor, constant: -8),
            playButton.heightAnchor.constraint(equalToConstant: 30),
            playButton.widthAnchor.constraint(equalToConstant: 30),
            
            videoTitle.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 10),
            videoTitle.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            videoTitle.trailingAnchor.constraint(equalTo: videoImage.trailingAnchor),
            videoTitle.heightAnchor.constraint(equalToConstant: 30),
            
            duration.trailingAnchor.constraint(equalTo: videoImage.trailingAnchor, constant: -8),
            duration.topAnchor.constraint(equalTo: videoImage.topAnchor, constant: 8),
            duration.heightAnchor.constraint(equalToConstant: 20),
            duration.widthAnchor.constraint(equalToConstant: 100)

   
        ])
    }
}
