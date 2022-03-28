//
//  DetailsViewController.swift
//  MovieDB MVC
//
//  Created by Anderson Sprenger on 04/03/22.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController, Storyboarded {
    var movie: Movie?
    var genreDictionary: [Int: String]?
        
    @IBOutlet private weak var poster: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var genres: UILabel!
    @IBOutlet private weak var overview: UILabel!
    @IBOutlet private weak var rating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        poster.layer.cornerRadius = 10
        self.title = "Details"
        
        navigationItem.largeTitleDisplayMode = .never
        
        guard let movie = movie else {
            return
        }
        
//        let posterCache = MovieDBService.imageCache()
//
//        if let posterImage = posterCache?.object(forKey: NSString(string: movie.urlImage)) as? UIImage {
//            poster.image = posterImage
//        }
        
        poster.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(movie.urlImage!)"))
        
        movieTitle.text = movie.title
        overview.text = movie.overview
        
        var genresString = ""
        
        for genre in movie.genres {
            genresString += genreDictionary?[genre as! Int] ?? ""
            genresString += ", "
        }
        
        genresString.removeLast()
        genresString.removeLast()
        
        genres.text = genresString
        rating.text = String(format: "%.1f", movie.rating.floatValue)
    }
}
