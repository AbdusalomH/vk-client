//
//  ViewController.swift
//  client-vk
//
//  Created by Mac on 6/25/22.
//

import UIKit
import WebKit


//OAuth
class AuthVC: UIViewController {
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        //Отключение перевода AutoresizingMask в Constraints
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.navigationDelegate = self
        
        return webView
    }()
    

    //Загружена рутовая view и будут известны ее размеры
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugPrint(view.frame) //размеры view
        
        setupViews()
        setupConstrains()
        authorizeToVK()
    }
    
    
    func setupViews() {
        view.addSubview(webView)
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func authorizeToVK() {
        
        //https://oauth.vk.com/authorize?client_id=1&display=page&redirect_uri=http://example.com/callback&scope=friends&response_type=code&v=5.131
        
        //Конструктор URL - URLComponents (ascii, percent encoding)
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"

        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7822904"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "271390"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1")
        ]
        
        debugPrint(urlComponents.url as Any)
        
        guard let url = urlComponents.url else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}

extension AuthVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        
        //https://oauth.vk.com/blank.html#access_token=533bacf01e11f55b536a565b57531ad114461ae8736d6506a3&expires_in=86400&user_id=8492&state=123456
        //url.fragment - это часть URL после #
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {

            //Продолжить слушать запросы браузера
            decisionHandler(.allow)
            return
        }

        
        let params: Dictionary<String, String> = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()) { partialResult, array in
                
                var dictionary = partialResult
                let key = array[0]
                let value = array[1]
                dictionary[key] = value
                return dictionary
            }
        
        
        guard let token = params["access_token"], let userId = params["user_id"], let expiresIn = params["expires_in"] else { return }
        
        Session.shared.accessToken = token
        Session.shared.userid = Int(userId) ?? 0 //nil coalescing operator -> оператор замены nil
        Session.shared.expiresIn = Int(expiresIn) ?? 0 //type convesion
        
        //Переход на контроллер следующий
        let friendsVC = FriendVC()
        navigationController?.pushViewController(friendsVC, animated: true)

        //Останавливаемся слушать запросы браузера
        decisionHandler(.cancel)
    }
}
