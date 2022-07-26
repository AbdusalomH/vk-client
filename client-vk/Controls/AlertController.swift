//
//  AlertController.swift
//  client-vk
//
//  Created by Mac on 7/14/22.
//

import UIKit

class AlertController: UIViewController {
    
    var alertTitle: String?
    var body: String?
    var button: String?
    
    init(titles: String, body: String, button: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = titles
        self.body       = body
        self.button     = button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let container       = UIView()
    let titleLabel      = UILabel()
    let bodyLabel       = UILabel()
    let actionButton    = UIButton()
    
    let padding: CGFloat = 20

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        configureContainer()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }
    
    
    private func configureContainer() {
        view.addSubview(container)
    
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.backgroundColor                           = .systemBackground
        container.layer.cornerRadius                        = 16
        container.layer.borderWidth                         = 2
        container.layer.borderColor                         = UIColor.white.cgColor
        
        
        NSLayoutConstraint.activate([
        
            container.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            container.widthAnchor.constraint(equalToConstant: 280),
            container.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        
        container.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = alertTitle ?? "Someting went wrong"
        titleLabel.textAlignment                            = .center
        titleLabel.font                                     = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor                                = .label
        titleLabel.adjustsFontSizeToFitWidth                = true
        titleLabel.minimumScaleFactor                       = 0.8
        titleLabel.lineBreakMode                            = .byTruncatingTail
        titleLabel.backgroundColor                          = .systemBackground
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        
        ])
    }
    
    func configureActionButton() {
        container.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        actionButton.setTitle(button ?? "Ok", for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor            = .systemPink
        actionButton.layer.cornerRadius         = 12
        actionButton.titleLabel?.font           = UIFont.preferredFont(forTextStyle: .headline)

        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
        
            actionButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])

    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func configureBodyLabel() {
        
        container.addSubview(bodyLabel)
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.text = body ?? "Wrong data recevied from server, please recheck your internet connection"
        
        bodyLabel.textAlignment = .center
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        bodyLabel.numberOfLines = 3
        bodyLabel.backgroundColor = .systemBackground

        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)

        ])
    }
}
