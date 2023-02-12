//
//  HomeViewModel.swift
//  KeyurApp
//
//  Created by Keyur on 11/02/23.
//

import Foundation

protocol MovieListListDelegate {
    
    var movieList: Box<[MovieListModel]> { get set }
    func getTrendingMovieList(page: Int)
    
}

struct MovieListViewModel {
    
    var current_page: Box<Int> = Box(Int())
    var movieList: Box<[MovieListModel]> = Box([])
    
    func getTrendingMovieList(page: Int) {
        APIManager.sharedInstance.callGetRequest(strUrl: getUrlWithKey(url: (API.MOVIE.TRENDING+"\(page)"))) { data in
            if data != nil {
                //if response is not empty
                do {
                    let success = try JSONDecoder().decode(MovieListResponse.self, from: data!) // decode the response into model
                    if(success.results.count > 0) {
                        if(success.page == 1) {
                            self.movieList.value = success.results
                        }else{
                            self.movieList.value += success.results
                        }
                        self.current_page.value += 1
                    }
                    else{
                        self.current_page.value = 0
                        print("No results found")
                    }
                }
                catch let err {
                    print("ERROR OCCURED WHILE DECODING: \(err.localizedDescription)")
                }
            }
        }
    }
}
