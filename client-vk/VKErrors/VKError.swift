//
//  VKError.swift
//  client-vk
//
//  Created by Mac on 7/10/22.
//

import Foundation


enum VKError: String, Error {
    
    case ResponseErroor = "Didn't get response! Please re-check your internet connection!"
    case DataError = "Invalid data"
    
}
