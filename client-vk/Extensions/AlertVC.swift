//
//  AlertVC.swift
//  client-vk
//
//  Created by Mac on 7/14/22.
//

import Foundation
import UIKit



extension UIViewController {
    
    func presentAlert(title: String, body: String, button: String) {
        DispatchQueue.main.async {
            let alert = AlertController(titles: title, body: body, button: button)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true)
        }
    }
}
