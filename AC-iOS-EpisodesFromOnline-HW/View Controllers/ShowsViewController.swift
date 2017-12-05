//
//  ViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q  on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {
    var tvShows = [TVShow]() {
        didSet {
            tableView.reloadData()
        }
    }
    var searchTerm = "" {
        didSet {
       loadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableViewAutomaticDimension
       
    }
    func loadData() {
        let str = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        let completion: ([TVShow]) -> Void = {(onlineTvShow: [TVShow]) in
            self.tvShows = onlineTvShow
        }
        TVShowAPIClient.manager.getTVShow(from: str, completionhandler: completion, errorHandler: {print($0)})
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesViewController {
        destination.id = tvShows[tableView.indexPathForSelectedRow!.row].show.id
        }
    }

}

extension ShowsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text ?? ""
        searchBar.resignFirstResponder()
    }
    
}
extension ShowsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "show cell", for: indexPath)
         cell.setNeedsLayout()
        let theTvShow = tvShows[indexPath.row]
        if let cell = cell as? TVShowTableViewCell {
            cell.nameLabel.text = theTvShow.show.name
            let rating = theTvShow.show.rating.average?.description ?? "No Found"
            cell.ratingLabel.text = "Rating: \(rating)"
            guard let theImageStr = theTvShow.show.image?.medium else {cell.postImage.image = #imageLiteral(resourceName: "noImageFound")
                return cell }
           // let imageUrlStr = theTvShow.show.image.medium
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) -> Void in
                cell.postImage.image = onlineImage
                cell.setNeedsLayout()
            }
            TVShowImageAPIClient.manager.getTVShow(from: theImageStr, completionhandler: completion, errorHandler: {print($0)})
            return cell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
