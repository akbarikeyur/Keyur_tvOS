//
//  HomeVC.swift
//  KeyurApp
//
//  Created by Keyur on 11/02/23.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var movieCV: UICollectionView!
    @IBOutlet weak var constraintHeightMovieCV: NSLayoutConstraint!
    
    private var movieListVM: MovieListViewModel = MovieListViewModel()
    let cellWidth : CGFloat = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        config()
    }

    func config() {
        registerCollectionView()
        movieListVM.current_page.value = API.DEFAULT_PAGE
        callAPI(page: movieListVM.current_page.value)
        bindAllData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK:- Collectionview Method
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func registerCollectionView() {
        movieCV.register(UINib.init(nibName: COLLECTION_VIEW_CELL.MoviePosterCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.MoviePosterCVC.rawValue)
        
        constraintHeightMovieCV.constant = cellWidth*1.5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListVM.movieList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cellWidth, height: constraintHeightMovieCV.constant)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : MoviePosterCVC = movieCV.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.MoviePosterCVC.rawValue, for: indexPath) as! MoviePosterCVC
        cell.setupDetails(movieListVM.movieList.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc : VideoDetailVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.VideoDetailVC.rawValue) as! VideoDetailVC
        vc.movieId = movieListVM.movieList.value[indexPath.row].id
        self.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (movieListVM.movieList.value.count-1) && movieListVM.current_page.value != 0 {
            movieListVM.getTrendingMovieList(page: movieListVM.current_page.value)
        }
    }
}

//MARK:- API Calling
extension HomeVC {
    func callAPI(page : Int) {
        movieListVM.getTrendingMovieList(page: page)
    }
    
    func bindAllData() {
        movieListVM.movieList.bind { [weak self](_) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.movieCV.reloadData()
            }
        }
    }
}
