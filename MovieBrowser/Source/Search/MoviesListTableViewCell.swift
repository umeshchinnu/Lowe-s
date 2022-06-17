//
//  MoviesListTableViewCell.swift
//  MovieBrowser
//
//  Created by Umesh Madatha on 06/16/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieDate: UILabel!
    
    @IBOutlet weak var lblMovieRating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var movie: Results? {
        didSet {
            updateData()
        }
    }
    func updateData() {
        self.lblMovieTitle.text = movie?.title ?? ""
        let date = movie?.releaseDate?.getDateFromString(isoDate: movie?.releaseDate ?? "")
        let dateStr = date?.getDateMMDDYYString(date: date ?? Date())
        self.lblMovieDate.text = dateStr
        self.lblMovieRating.text = "\(movie?.voteAverage ?? 0.0)"
    }
}
extension String {
    
    func getDateFromString(isoDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: isoDate) ?? Date()
    }
}
extension Date {
    func getDateMMDDYYString(date: Date) -> String {
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = "MMM dd YYYY"
        // Convert Date to String
        return dateFormatter.string(from: date)
        
    }
}
