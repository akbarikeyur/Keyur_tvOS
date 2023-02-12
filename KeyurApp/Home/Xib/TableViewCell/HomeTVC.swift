//
//  HomeTVC.swift
//  KeyurApp
//
//  Created by Keyur on 11/02/23.
//

import UIKit

protocol HomeTVCDelegate: AnyObject {
    func didSelectItem()
}

class HomeTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var movieCV: UICollectionView!
    @IBOutlet weak var constraintHeightMovieCV: NSLayoutConstraint!
    
    weak var delegate: HomeTVCDelegate?
    let cellWidth : CGFloat = 500
    var movieListVM: MovieListViewModel = MovieListViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerCollectionView()
        constraintHeightMovieCV.constant = cellWidth*1.5
    }

    func setupDetails() {
        titleLbl.text = "Top Movies"
        movieCV.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK:- Collectionview Method
extension HomeTVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func registerCollectionView() {
        movieCV.register(UINib.init(nibName: COLLECTION_VIEW_CELL.MoviePosterCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.MoviePosterCVC.rawValue)
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
        delegate?.didSelectItem()
    }
}
