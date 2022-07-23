//
//  hours+extension.swift
//  client-vk
//
//  Created by Mac on 7/22/22.
//

import Foundation

func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

extension Int {
    func addZero() -> String {
        return self < 10 ? "0\(self)" : "\(self)"
    }
}
