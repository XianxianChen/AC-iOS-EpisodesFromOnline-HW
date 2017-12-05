//
//  Episode.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct TVShow: Codable {
    let show: ShowList
}

struct ShowList: Codable {
    let id: Int
    let name: String
    let rating: RatingInfo
    let image: ImageInfo?
    let summary: String
    let _links: LinksInfo
}

struct RatingInfo: Codable {
    let average: Double?
}
struct ImageInfo: Codable {
    let medium: String
    let original: String
}
struct LinksInfo: Codable {
    let link: SelfInfo
    
    enum CodingKeys: String, CodingKey {
        case link = "self"
    }
}
struct SelfInfo: Codable {
    let href: String
}
