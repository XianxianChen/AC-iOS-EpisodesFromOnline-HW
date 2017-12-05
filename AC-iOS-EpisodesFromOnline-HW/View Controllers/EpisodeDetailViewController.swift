//
//  EpisodeDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    var episode: Episode?
  
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let episode = self.episode else {return}
        nameLabel.text = episode.name
        episodeLabel.text = "Season: \(episode.season); Number: \(episode.number)"
        textView.text = episode.summary
        guard let theImageStr = episode.image?.medium else {self.imageView.image = #imageLiteral(resourceName: "noImageFound")
            return}
        
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) -> Void in
            self.imageView.image = onlineImage
        }
        TVShowImageAPIClient.manager.getTVShow(from: theImageStr, completionhandler: completion, errorHandler: {print($0)})
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
