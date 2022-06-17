//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imageViewMovie: UIImageView!
    var movie: Results?
    @IBOutlet weak var textviewContent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.lblTitle.text = movie?.title ?? ""
        self.lblReleaseDate.text = "release Date: \(movie?.releaseDate ?? "")"
        self.textviewContent.text = movie?.overview ?? ""
        self.imageViewMovie.image = UIImage.init(named: "placeholder")
        let url = "https://image.tmdb.org/t/p/w500\(movie?.posterPath ?? "")"
        self.imageViewMovie.loadFrom(URLAddress: url)
    }
}
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
