//
//  Models.swift
//  iTunesAPI_Demo
//
//  Created by 保坂篤志 on 2022/11/21.
//

import Foundation

class Response: Codable {
    
    var resultCount: Int
    var results: [MusicData]
}

class MusicData: Codable {
    
    var trackName: String
    var artistName: String
}
