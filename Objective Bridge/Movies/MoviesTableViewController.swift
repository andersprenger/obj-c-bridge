//
//  ViewController.swift
//  Objective Bridge
//
//  Created by Anderson Sprenger on 25/03/22.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    var coordinator: MainCoordinator? = nil
    var page = 1

    var popularMovies: [Movie] = []
    var nowPlayingMovies: [Movie] = []
    var searchedMovies: [Movie] = []
    
    var genreDictionary: [Int: String]?
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: MovieCell.identifier, bundle: nil), forCellReuseIdentifier: MovieCell.identifier)
        tableView.separatorStyle = .none
        
        self.title = "Movies"
        
        MovieDBService.fetchGenres()
        
        MovieDBService.fetchPopularMovies { moviesNSMutableArray in
            guard let movies = moviesNSMutableArray! as NSArray as? [Movie] else {
                return
            }
            
            self.popularMovies = movies
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        MovieDBService.fetchNowPlayingMovies(byPage: NSNumber(integerLiteral: page)) { moviesNSMutableArray in
            guard let movies = moviesNSMutableArray! as NSArray as? [Movie] else {
                return
            }
            
            self.nowPlayingMovies = movies
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    enum sections: CaseIterable {
        case popular, nowPlaying
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections.allCases[section] {
        case .popular:
            return "Popular Movies"
        case .nowPlaying:
            return "Now Playing"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections.allCases[section] {
        case .popular:
            return popularMovies.count > 2 ? 2 : popularMovies.count
        case .nowPlaying:
            return nowPlayingMovies.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        
        let movie: Movie
        
        switch sections.allCases[indexPath.section] {
        case .popular:
            movie = popularMovies[indexPath.row]
        case .nowPlaying:
            movie = nowPlayingMovies[indexPath.row]
        }
        
//        let posterCache = MovieDBService.imageCache()
//
//        if let poster = posterCache?.object(forKey: NSString(string: movie.urlImage)) as? UIImage {
//            cell.poster.image = poster
//        }
        
        cell.poster.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(movie.urlImage!)"))

        cell.title.text = movie.title
        cell.overview.text = movie.overview
        cell.rating.text = String(format: "%.1f", movie.rating.floatValue)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie: Movie
        
        switch sections.allCases[indexPath.section] {
        case .popular:
            movie = popularMovies[indexPath.row]
        case .nowPlaying:
            movie = nowPlayingMovies[indexPath.row]
        }
        
        coordinator?.showDetails(of: movie, genreDictionary: genreDictionary)
    }
}

