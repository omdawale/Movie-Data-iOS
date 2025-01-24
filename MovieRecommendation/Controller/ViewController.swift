//
//  ViewController.swift
//  MovieRecommendation
//
//  Created by Omkar Dawale on 14/01/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchTextField: UITextField!
    
    var movieManager = MovieManager()
    var movieDetails: MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieManager.delegate = self
        searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        if let movieName = searchTextField.text {
            movieManager.fetchMovie(movieName: movieName)
        }
        searchTextField.text = nil
    }
    
    @IBAction func findMovie(_ sender: UIButton) {
        searchTextField.endEditing(true)
        if let movieName = searchTextField.text {
            movieManager.fetchMovie(movieName: movieName)
        }
        searchTextField.text = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsController
            destinationVC.movieDetails = movieDetails // Pass the movie details
        }
    }


    
}

//MARK: - UITextFieldDelegate

extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something"
            return false
        }
    }
}

////MARK: - MovieDetailsUpdateDelegate
extension ViewController: MovieManagerDelegate {
    func didUpdateMovie(_ movieManager: MovieManager, mov: MovieModel) {
        DispatchQueue.main.async {
            self.movieDetails = mov // Save the movie details
            self.performSegue(withIdentifier: "goToResult", sender: self) // Perform segue only after receiving data
        }
    }

    func didFailedError(error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}


