//
//  MovieListModel.swift
//  KeyurApp
//
//  Created by Keyur on 11/02/23.
//

import Foundation

// MARK: - UserResponse
struct MovieListResponse: Codable {
    let page: Int
    let results: [MovieListModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieListModel: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title: String
    let originalLanguage: String
    let originalTitle, overview, posterPath: String
    let mediaType: String
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult) ?? DocumentDefaultValues.Empty.bool
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath) ?? DocumentDefaultValues.Empty.string
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? DocumentDefaultValues.Empty.int
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? DocumentDefaultValues.Empty.string
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage) ?? DocumentDefaultValues.Empty.string
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle) ?? DocumentDefaultValues.Empty.string
        overview = try values.decodeIfPresent(String.self, forKey: .overview) ?? DocumentDefaultValues.Empty.string
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? DocumentDefaultValues.Empty.string
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType) ?? DocumentDefaultValues.Empty.string
        genreIDS = try values.decodeIfPresent([Int].self, forKey: .genreIDS) ?? []
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity) ?? DocumentDefaultValues.Empty.double
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate) ?? DocumentDefaultValues.Empty.string
        video = try values.decodeIfPresent(Bool.self, forKey: .video) ?? DocumentDefaultValues.Empty.bool
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage) ?? DocumentDefaultValues.Empty.double
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount) ?? DocumentDefaultValues.Empty.int
    }
}
