//
//  DataModels.swift
//  MovieBrowser
//
//  Created by Umesh Madatha on 06/16/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct MoviesModel: Codable {

    let page: Int
    let results: [Results]
    let totalPages: Int
    let totalResults: Int

    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        results = try values.decode([Results].self, forKey: .results)
        totalPages = try values.decode(Int.self, forKey: .totalPages)
        totalResults = try values.decode(Int.self, forKey: .totalResults)
    }

}
struct Results: Codable {

    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    private enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        adult = try? values?.decode(Bool.self, forKey: .adult)
        backdropPath = try? values?.decode(String.self, forKey: .backdropPath)
        genreIds = try? values?.decode([Int].self, forKey: .genreIds)
        id = try? values?.decode(Int.self, forKey: .id)
        originalLanguage = try? values?.decode(String.self, forKey: .originalLanguage)
        originalTitle = try? values?.decode(String.self, forKey: .originalTitle)
        overview = try? values?.decode(String.self, forKey: .overview)
        popularity = try? values?.decode(Double.self, forKey: .popularity)
        posterPath = try? values?.decode(String.self, forKey: .posterPath)
        releaseDate = try? values?.decode(String.self, forKey: .releaseDate)
        title = try? values?.decode(String.self, forKey: .title)
        video = try? values?.decode(Bool.self, forKey: .video)
        voteAverage = try? values?.decode(Double.self, forKey: .voteAverage)
        voteCount = try? values?.decode(Int.self, forKey: .voteCount)
    }

}
