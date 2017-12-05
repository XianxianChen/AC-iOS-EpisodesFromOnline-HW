//
//  TVShowAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class TVShowAPIClient {
    private init() {}
    static let manager = TVShowAPIClient()
    func getTVShow(from urlStr: String,
                   completionhandler: @escaping ([TVShow]) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
            let onlineTVShow = try JSONDecoder().decode([TVShow].self, from: data)
                completionhandler(onlineTVShow)
            } catch {
                errorHandler(error)
            }
            
        }
        NetworkHelper.manager.performDataTask(wtih: url, completionHandler: completion, errorHandler: errorHandler)
    }
}


class EpisodesAPIClient {
    private init() {}
    static let manager = EpisodesAPIClient()
    func getEpisodes(from urlStr: String,
                   completionhandler: @escaping ([Episode]) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let onlineEpisodes = try JSONDecoder().decode([Episode].self, from: data)
                completionhandler(onlineEpisodes)
            } catch {
                errorHandler(error)
            }
            
        }
        NetworkHelper.manager.performDataTask(wtih: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
