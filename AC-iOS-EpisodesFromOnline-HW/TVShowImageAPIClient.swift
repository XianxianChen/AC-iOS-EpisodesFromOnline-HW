//
//  TVShowImageAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit
class TVShowImageAPIClient {
    private init() {}
    static let manager = TVShowImageAPIClient()
    func getTVShow(from urlStr: String,
                   completionhandler: @escaping (UIImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
                guard let onlineImage = UIImage(data: data) else {return}
                completionhandler(onlineImage)
            
        }
        NetworkHelper.manager.performDataTask(wtih: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
