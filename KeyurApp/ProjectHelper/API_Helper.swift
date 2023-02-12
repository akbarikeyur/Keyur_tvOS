//
//  API_Helper.swift
//  KeyurApp
//
//  Created by Keyur on 11/02/23.
//

import Foundation

//MARK: - API
struct API {
    
    //Development
    static let BASE_URL = "https://api.themoviedb.org/3/"
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/"
    static let API_KEY = "c40e50164815a1166ece02ec599b7c6d"
    static let DEFAULT_PAGE = 1
    
    struct IMAGE {
        static let POSTER = API.IMAGE_BASE_URL + "w780/"
        static let BACCKDROP = API.IMAGE_BASE_URL + "w1280/"
        static let FALLBACCK = API.IMAGE_BASE_URL + "w500/"
    }

    
    struct MOVIE {
        static let TRENDING = API.BASE_URL + "trending/movie/week?page="
        static let DETAIL = API.BASE_URL + "movie/"
    }
    
}

func getUrlWithKey(url : String) -> String {
    var newUrl = url
    if newUrl.contains("?") {
        newUrl += "&api_key=\(API.API_KEY)"
    }else{
        newUrl += "?api_key=\(API.API_KEY)"
    }
    return newUrl
}
