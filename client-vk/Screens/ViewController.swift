//
//  ViewController.swift
//  client-vk
//
//  Created by Mac on 6/25/22.
//

import UIKit
import WebKit

class AuthVC: UIViewController {
    
    var webView: WKWebView = {
        let webView = WKWebView()
        return webView

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        setupViews()
        setupConstraints()
        loadURL()
    }
    
    
    func setupViews() {
        
        view.addSubview(webView)
 
    }
    
    func setupConstraints() {
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)

        ])
 
    }
    
    
    func loadURL() {
        
        let baseURL = "https://www.codewars.com/users/AbdusalomH"

        let request = URLRequest(url: URL(string: baseURL)!)
        
        webView.load(request)
  
    }
    
    func authorizationVK() {
        
        
        
        
    }
}

