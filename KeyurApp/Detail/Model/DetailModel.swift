//
//  DetailModel.swift
//  KeyurApp
//
//  Created by Keyur on 11/02/23.
//

import Foundation

struct TitleValueModel {
    var title, value : String!
    
    init(title : String, value: String) {
        self.title = title
        self.value = value
    }
}

// MARK: - UserResponse
struct MovieDetailModel: Codable {
    let adult: Bool
    let backdropPath: String
    let belongsToCollection: BelongsToCollectionModel
    let budget: Int
    let genres: [GenreModel]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompanyModel]
    let productionCountries: [ProductionCountryModel]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguageModel]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult) ?? DocumentDefaultValues.Empty.bool
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath) ?? DocumentDefaultValues.Empty.string
        belongsToCollection = try values.decodeIfPresent(BelongsToCollectionModel.self, forKey: .belongsToCollection) ?? BelongsToCollectionModel.init()
        budget = try values.decodeIfPresent(Int.self, forKey: .budget) ?? DocumentDefaultValues.Empty.int
        genres = try values.decodeIfPresent([GenreModel].self, forKey: .genres) ?? [GenreModel]()
        homepage = try values.decodeIfPresent(String.self, forKey: .homepage) ?? DocumentDefaultValues.Empty.string
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? DocumentDefaultValues.Empty.int
        imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID) ?? DocumentDefaultValues.Empty.string
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? DocumentDefaultValues.Empty.string
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage) ?? DocumentDefaultValues.Empty.string
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle) ?? DocumentDefaultValues.Empty.string
        overview = try values.decodeIfPresent(String.self, forKey: .overview) ?? DocumentDefaultValues.Empty.string
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? DocumentDefaultValues.Empty.string
        productionCompanies = try values.decodeIfPresent([ProductionCompanyModel].self, forKey: .productionCompanies) ?? [ProductionCompanyModel]()
        productionCountries = try values.decodeIfPresent([ProductionCountryModel].self, forKey: .productionCountries) ?? [ProductionCountryModel]()
        revenue = try values.decodeIfPresent(Int.self, forKey: .revenue) ?? DocumentDefaultValues.Empty.int
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime) ?? DocumentDefaultValues.Empty.int
        spokenLanguages = try values.decodeIfPresent([SpokenLanguageModel].self, forKey: .spokenLanguages) ?? [SpokenLanguageModel]()
        status = try values.decodeIfPresent(String.self, forKey: .status) ?? DocumentDefaultValues.Empty.string
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline) ?? DocumentDefaultValues.Empty.string
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity) ?? DocumentDefaultValues.Empty.double
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate) ?? DocumentDefaultValues.Empty.string
        video = try values.decodeIfPresent(Bool.self, forKey: .video) ?? DocumentDefaultValues.Empty.bool
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage) ?? DocumentDefaultValues.Empty.double
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount) ?? DocumentDefaultValues.Empty.int
    }
    
    init() {
        adult = DocumentDefaultValues.Empty.bool
        backdropPath = DocumentDefaultValues.Empty.string
        belongsToCollection = BelongsToCollectionModel.init()
        budget = DocumentDefaultValues.Empty.int
        genres = [GenreModel]()
        homepage = DocumentDefaultValues.Empty.string
        id = DocumentDefaultValues.Empty.int
        imdbID = DocumentDefaultValues.Empty.string
        title = DocumentDefaultValues.Empty.string
        originalLanguage = DocumentDefaultValues.Empty.string
        originalTitle = DocumentDefaultValues.Empty.string
        overview = DocumentDefaultValues.Empty.string
        posterPath = DocumentDefaultValues.Empty.string
        productionCompanies = [ProductionCompanyModel]()
        productionCountries = [ProductionCountryModel]()
        revenue = DocumentDefaultValues.Empty.int
        runtime = DocumentDefaultValues.Empty.int
        spokenLanguages = [SpokenLanguageModel]()
        status = DocumentDefaultValues.Empty.string
        tagline = DocumentDefaultValues.Empty.string
        popularity = DocumentDefaultValues.Empty.double
        releaseDate = DocumentDefaultValues.Empty.string
        video = DocumentDefaultValues.Empty.bool
        voteAverage = DocumentDefaultValues.Empty.double
        voteCount = DocumentDefaultValues.Empty.int
    }
    
}

// MARK: - BelongsToCollection
struct BelongsToCollectionModel: Codable {
    let id: Int
    let name, posterPath, backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? DocumentDefaultValues.Empty.int
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? DocumentDefaultValues.Empty.string
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? DocumentDefaultValues.Empty.string
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath) ?? DocumentDefaultValues.Empty.string
    }
    
    init() {
        id = DocumentDefaultValues.Empty.int
        name = DocumentDefaultValues.Empty.string
        posterPath = DocumentDefaultValues.Empty.string
        backdropPath = DocumentDefaultValues.Empty.string
    }
}

// MARK: - Genre
struct GenreModel: Codable {
    let id: Int
    let name: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? DocumentDefaultValues.Empty.int
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? DocumentDefaultValues.Empty.string
    }
}

// MARK: - ProductionCompany
struct ProductionCompanyModel: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? DocumentDefaultValues.Empty.int
        logoPath = try values.decodeIfPresent(String.self, forKey: .logoPath) ?? DocumentDefaultValues.Empty.string
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? DocumentDefaultValues.Empty.string
        originCountry = try values.decodeIfPresent(String.self, forKey: .originCountry) ?? DocumentDefaultValues.Empty.string
    }
}

// MARK: - ProductionCountry
struct ProductionCountryModel: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iso3166_1 = try values.decodeIfPresent(String.self, forKey: .iso3166_1) ?? DocumentDefaultValues.Empty.string
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? DocumentDefaultValues.Empty.string
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguageModel: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        englishName = try values.decodeIfPresent(String.self, forKey: .englishName) ?? DocumentDefaultValues.Empty.string
        iso639_1 = try values.decodeIfPresent(String.self, forKey: .iso639_1) ?? DocumentDefaultValues.Empty.string
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? DocumentDefaultValues.Empty.string
    }
}
