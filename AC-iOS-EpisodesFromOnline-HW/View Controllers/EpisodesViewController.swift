//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    var episodes = [Episode]() {
        didSet {
            tableView.reloadData()
        }
    }
    var id: Int? {
        didSet{
        loadEpisode()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     self.tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func loadEpisode() {
        guard let id = id else {return}
        let urlStr = "http://api.tvmaze.com/shows/\(id)/episodes"
        let completion: ([Episode]) -> Void = {(onlineEpisode: [Episode]) in
            self.episodes = onlineEpisode
        }
        EpisodesAPIClient.manager.getEpisodes(from: urlStr, completionhandler: completion, errorHandler: {print($0)})
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeDetailViewController {
            destination.episode = self.episodes[tableView.indexPathForSelectedRow!.row]
        }
    }


}
extension EpisodesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episode cell", for: indexPath)
        if let cell = cell as? EpisodesTableViewCell {
            cell.nameLabel.text = episodes[indexPath.row].name
            cell.episodeLabel.text = "Season: \(episodes[indexPath.row].season); Number: \(episodes[indexPath.row].number)"
            guard let theImageStr = episodes[indexPath.row].image?.medium else {cell.episodeImageView.image = #imageLiteral(resourceName: "noImageFound")
                    return cell }
            // let imageUrlStr = theTvShow.show.image.medium
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) -> Void in
                cell.episodeImageView.image = onlineImage
            }
            TVShowImageAPIClient.manager.getTVShow(from: theImageStr, completionhandler: completion, errorHandler: {print($0)})
            return cell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}





