//
//  PodcastCell.swift
//  PodcastsFeed
//
//  Created by Nav on 27/04/23.
//

import UIKit

class PodcastCell: UITableViewCell {

    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelFavorite: UILabel!
    @IBOutlet weak var imageThumnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageThumnail.layer.cornerRadius = 20
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
