//
//  VideoDetailsVC.swift
//  client-vk
//
//  Created by Mac on 7/20/22.
//

import UIKit
import WebKit

class VideoDetailsVC: UIViewController {
    
    let wkweb = WKWebView()
    
    let videoUrl: String
    
    init(videolUrl: String) {
        self.videoUrl = videolUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        
    }
    
    func configureUI() {
        view.addSubview(wkweb)
        
        wkweb.pinToEdges(to: view)
        
        guard let url = URL(string: videoUrl) else {return}
        
        let urlRequest = URLRequest(url: url)

        wkweb.load(urlRequest)
    
    }
        
}
    
