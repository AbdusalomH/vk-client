//
//  UIView+PinEdges.swift
//  client-vk
//
//  Created by Mac on 6/28/22.
//

import UIKit

extension UIView {
    
    func pinToEdges(to: UIView) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: to.topAnchor),
            self.leadingAnchor.constraint(equalTo: to.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: to.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: to.bottomAnchor)
        ])
    }
}
