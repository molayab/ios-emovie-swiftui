//
//  VideoModel.swift
//  eMovie
//
//  Created by Mateo Olaya on 25/10/22.
//

import Foundation

struct VideoModel: Codable {
    var type: String
    var site: String
    var id: String
    var official: Bool
    var key: String
}

struct VideosModel: Codable {
    var results: [VideoModel]
}
