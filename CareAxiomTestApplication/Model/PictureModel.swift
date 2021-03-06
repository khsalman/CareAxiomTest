//
//  PictureModel.swift
//  CareAxiomTestApplication
//
//  Created by Khawaja Salman Nadeem on 11/09/2021.
//

import Foundation

// MARK: - PictureDataDic 
struct PicDataDic : Codable {
    var dic : [String : [PictureData]]
}

// MARK: - PictureData
struct PictureData : Codable {
    
    let id : Int
    let albumId : Int
    let title : String
    let url : String
    let thumbnailUrl : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumId = "albumId"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
}


