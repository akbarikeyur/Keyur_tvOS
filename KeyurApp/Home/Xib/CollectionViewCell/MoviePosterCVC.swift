//
//  MoviePosterCVC.swift
//  KeyurApp
//
//  Created by Keyur on 11/02/23.
//

import UIKit

class MoviePosterCVC: UICollectionViewCell {
    
    @IBOutlet weak var posterImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImg.layer.cornerRadius = 20
        posterImg.clipsToBounds = true
        posterImg.layer.borderWidth = 10
        posterImg.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setupDetails(_ dict : MovieListModel) {
        posterImg.downloadCachedImage(urlString: API.IMAGE.POSTER+dict.posterPath)
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({ [weak self] in
            if self?.isFocused ?? false{
                self?.posterImg.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)
                self?.posterImg.layer.borderColor = UIColor.white.cgColor
            } else {
                self?.posterImg.transform = CGAffineTransform(scaleX: 1, y: 1)
                self?.posterImg.layer.borderColor = UIColor.clear.cgColor
            }
        }, completion: nil)
    }
}
