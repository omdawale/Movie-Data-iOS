//
//  ResultsController.swift
//  MovieRecommendation
//
//  Created by Omkar Dawale on 14/01/25.
//

import UIKit

class ResultsController: UIViewController {
    
    var movieManager = MovieManager()
    var movieDetails: MovieModel?
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieCast: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieCollection: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieCountry: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //movieManager.delegate = self
        if let movie = movieDetails {
            movieName.text = "\(movie.movieTitle)"
            movieCast.text = "Cast: \(movie.cast)"          // Assuming cast is a String
            movieDirector.text = "Director: \(movie.maker)" // Assuming maker is a String
            movieCollection.text = "Box Office: \(movie.collection)" // Assuming collection is a String or number
            movieYear.text = "Year: \(movie.year)"         // Assuming year is a String or number
            movieRating.text = "Rating: \(movie.rating)"   // Assuming rating is a String or number
            movieCountry.text = "Country: \(movie.country)" //
            // Load image from the poster URL
            if let posterURL = URL(string: movie.poster) {
                loadImage(from: posterURL)
            }
        }
    }
    
    // Function to load the image
       func loadImage(from url: URL) {
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               if let error = error {
                   print("Error loading image: \(error.localizedDescription)")
                   return
               }
               if let data = data, let image = UIImage(data: data) {
                   DispatchQueue.main.async {
                       self.moviePoster.image = image
                   }
               }
           }.resume()
       }
       
       @IBAction func tryDifferent(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
       }
   }

////MARK: - MovieDetailsUpdateDelegate
//
//extension ResultsController: MovieManagerDelegate{
//    func didUpdateMovie(_ movieManager: MovieManager, mov: MovieModel) {
//        DispatchQueue.main.async{
//            self.movieName.text = mov.movieTitle
//            self.movieDirector.text = mov.maker
//        }
//    }
//    
//    func didFailedError(error: any Error) {
//        print(error)
//    }
//}
