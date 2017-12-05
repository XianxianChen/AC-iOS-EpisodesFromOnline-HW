//
//  Episodes.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Episode: Codable{
    let name: String
    let season: Int
    let number: Int
    let image: ImageDict?
    let summary: String
}
struct ImageDict: Codable {
    let medium: String
    let original: String
}


