//
//  DetailViewModel.swift
//  KeyurApp
//
//  Created by Keyur on 12/02/23.
//

import Foundation

protocol DetailViewDelegate {
    var movieDetail: Box<MovieDetailModel> { get set }
    func getMovieDdetail(movie_id: Int)
    
}

struct DetailViewModel {
    
    var movieDetail: Box<MovieDetailModel> = Box(MovieDetailModel())
    
    func getMovieDdetail(movie_id: Int) {
        APIManager.sharedInstance.callGetRequest(strUrl: getUrlWithKey(url: (API.MOVIE.DETAIL+"\(movie_id)"))) { data in
            if data != nil {
                //if response is not empty
                do {
                    let success = try JSONDecoder().decode(MovieDetailModel.self, from: data!) // decode the response into model
                    self.movieDetail.value = success.self
                }
                catch let err {
                    print("ERROR OCCURED WHILE DECODING: \(err.localizedDescription)")
                }
            }
        }
    }
}
