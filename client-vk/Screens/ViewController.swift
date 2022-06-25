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
        //loadURL()
        authorizationVK()
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
        
        var urlComponents: URLComponents = URLComponents()
        
        urlComponents.scheme = "https"
        
        urlComponents.host = "oauth.vk.com"
        
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [URLQueryItem(name: "client_id", value:"7822904"),
                                    URLQueryItem(name: "display", value: "mobile"),
                                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                                    URLQueryItem(name: "scope", value: "1032192"),
                                    URLQueryItem(name: "response_type", value: "token"),
                                    URLQueryItem(name: "v", value: "5.131"),
                                    URLQueryItem(name: "revoke", value: "1")]
        
        // URL компонентся для создания безопасного url
        guard let url = urlComponents.url else {return}
        
        let request = URLRequest(url: url)
        
        webView.load(request)
        
    }
    
    // 1032192
}

