//
//  NetworkHelper.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let mySession = URLSession(configuration: .default)
     func performDataTask(wtih url: URL, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        mySession.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data else {return}
            DispatchQueue.main.async {
            if let error = error {
                errorHandler(error)
                return
            }
                completionHandler(data)
            }
        }.resume() //*** resume means start.
    }
            
}
