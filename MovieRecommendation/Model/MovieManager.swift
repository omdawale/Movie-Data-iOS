//
//  MovieManager.swift
//  MovieRecommendation
//
//  Created by Omkar Dawale on 14/01/25.
//

import Foundation

protocol MovieManagerDelegate{
    func didUpdateMovie(_ movieManager: MovieManager, mov: MovieModel)
    func didFailedError(error: Error)
}

struct MovieManager {
    let movieURL = "https://www.omdbapi.com/?apikey=4c79a254"
    
    var delegate: MovieManagerDelegate?
    
    func fetchMovie(movieName: String){
        let urlString = "\(movieURL)&t=\(movieName)"
        perfromRequest(urlString: urlString)
    }
    
    func perfromRequest(urlString: String) {
        ///1. Create URL
        if let url = URL(string: urlString){
            ///2. Create Session
            let session = URLSession(configuration: .default)
            ///3. GIve a Task to session
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data{
                    if let movieDetails = parseJson(movieData: safeData){
                        delegate?.didUpdateMovie(self, mov: movieDetails)
                    }
                    
                }
            }
            ///4. Start task to fetch the movie data from servers
            task.resume()
        }
    }
    
    func parseJson(movieData: Data) -> MovieModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(MovieData.self, from: movieData)
            let moviename = decodeData.Title
            let cast = decodeData.Actors
            let dir = decodeData.Director
            let collection = decodeData.BoxOffice
            let releaseYear = decodeData.Year
            let rating = decodeData.imdbRating
            let country = decodeData.Country
            let poster = decodeData.Poster
            
            let movies = MovieModel(movieTitle: moviename,cast: cast, maker: dir, collection: collection, year: releaseYear,rating: rating, country: country, poster: poster)
            print(movies)
            return movies
        } catch {
            delegate?.didFailedError(error: error)
            return nil
        }
    }
    
}

