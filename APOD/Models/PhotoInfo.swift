//
//  PhotoInfo.swift
//  APOD
//
//  Created by Gil Rodarte on 06/11/20.
//

import Foundation

struct PhotoInfo: Codable {
   
    let title: String
    let explanation: String
    let url: String
    let copyright: String?
    
    var photoURL: URL? {
        URL(string: url)
    }
    
}
