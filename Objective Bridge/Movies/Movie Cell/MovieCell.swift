//
//  MovieCell.swift
//  Objective Bridge
//
//  Created by Anderson Sprenger on 25/03/22.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let identifier: String = "MovieCell"
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        poster.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
