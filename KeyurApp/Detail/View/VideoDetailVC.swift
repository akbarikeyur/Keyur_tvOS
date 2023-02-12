//
//  VideoDetailVC.swift
//  KeyurApp
//
//  Created by Keyur on 11/02/23.
//

import UIKit
import AVKit

class VideoDetailVC: UIViewController {

    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tagLineLbl: UILabel!
    @IBOutlet weak var imdbRateLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constraintHeightTblView: NSLayoutConstraint!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var adultImg: UIImageView!
    
    var playerTitleLbl : UILabel?
    var playerSubTitleLbl : UILabel?
    
    var arrTitleValueData = [TitleValueModel]()
    var movieId = 0
    var detailVM = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        config()
    }
    
    func config() {
        adultImg.isHidden = true
        registerTableViewMethod()
        callAPI()
        bindAllData()
    }
    
    //MARK:- Button click event
    @IBAction func clickToPlay(_ sender: UIButton) {
        playVideo()
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

//MARK:- AVPlayer
extension VideoDetailVC: AVPlayerViewControllerDelegate {
    
    func playVideo() {
        guard let url = URL(string: VIDEO_ARRAY.randomElement()!) else { return }

        //Setup vidoe title lable
        playerTitleLbl = UILabel(frame: CGRect(x: 50, y: 20, width: UIScreen.main.bounds.size.width-40, height: 30));
        playerTitleLbl!.text = titleLbl.text
        playerTitleLbl?.font = UIFont.boldSystemFont(ofSize: 25)
        playerTitleLbl!.textColor = .white
        
        //Setup video subtitle lable
        playerSubTitleLbl = UILabel(frame: CGRect(x: 50, y: (playerTitleLbl?.frame.origin.y)! + (playerTitleLbl?.frame.height)!, width: UIScreen.main.bounds.size.width-40, height: 30));
        playerSubTitleLbl!.text = tagLineLbl.text
        playerSubTitleLbl?.font = UIFont.systemFont(ofSize: 25)
        playerSubTitleLbl!.textColor = .white
        
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)

        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.delegate = self
        controller.contentOverlayView?.addSubview(playerTitleLbl!)
        controller.contentOverlayView?.addSubview(playerSubTitleLbl!)
        controller.player = player

        // Modally present the player and call the player's play() method when complete.
        self.present(controller, animated: true) {
            player.play()
        }
    }
    
    func playerViewController(_ playerViewController: AVPlayerViewController, willTransitionToVisibilityOfTransportBar visible: Bool, with coordinator: AVPlayerViewControllerAnimationCoordinator) {
        print("IS VISIBLAE : \(visible)")
        playerTitleLbl?.isHidden = !visible
        playerSubTitleLbl?.isHidden = !visible
    }
}

//MARK:- Tableview Method
extension VideoDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.TwoLableDetailTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.TwoLableDetailTVC.rawValue)
        tblView.estimatedRowHeight = 30
        tblView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitleValueData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TwoLableDetailTVC = tblView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.TwoLableDetailTVC.rawValue) as! TwoLableDetailTVC
        cell.setupDetails(arrTitleValueData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func updateTblHeight() {
        constraintHeightTblView.constant = CGFloat.greatestFiniteMagnitude
        tblView.reloadData()
        tblView.layoutIfNeeded()
        constraintHeightTblView.constant = tblView.contentSize.height
    }
}

//MARK:- API Calling
extension VideoDetailVC {
    func callAPI() {
        detailVM.getMovieDdetail(movie_id: movieId)
    }
    
    func bindAllData() {
        detailVM.movieDetail.bind { [weak self](_) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.setupDetails()
            }
        }
    }
    
    func setupDetails() {
        coverImg.downloadCachedImage(urlString: API.IMAGE.BACCKDROP+detailVM.movieDetail.value.backdropPath)
        posterImg.downloadCachedImage(urlString: API.IMAGE.POSTER+detailVM.movieDetail.value.posterPath)
        adultImg.isHidden = !detailVM.movieDetail.value.adult
        titleLbl.text = detailVM.movieDetail.value.title
        tagLineLbl.text = detailVM.movieDetail.value.tagline
        imdbRateLbl.text = displayFlotingValue(detailVM.movieDetail.value.voteAverage)
        durationLbl.text = getSecondsToTime(detailVM.movieDetail.value.runtime)
        releaseDateLbl.text = getReleaseDate(strDate: detailVM.movieDetail.value.releaseDate)
        descriptionLbl.text = detailVM.movieDetail.value.overview
        
        arrTitleValueData = [TitleValueModel]()
        if(!detailVM.movieDetail.value.productionCompanies.isEmpty) {
            arrTitleValueData.append(TitleValueModel(title: "Production", value: detailVM.movieDetail.value.productionCompanies.map({$0.name}).joined(separator: ", ")))
        }
        if(!detailVM.movieDetail.value.genres.isEmpty) {
            arrTitleValueData.append(TitleValueModel(title: "Genres", value: detailVM.movieDetail.value.genres.map({$0.name}).joined(separator: ", ")))
        }
        if(!detailVM.movieDetail.value.spokenLanguages.isEmpty) {
            arrTitleValueData.append(TitleValueModel(title: "Audio Language", value: detailVM.movieDetail.value.spokenLanguages.map({$0.name}).joined(separator: ", ")))
        }
        if detailVM.movieDetail.value.voteCount > 0 {
            arrTitleValueData.append(TitleValueModel(title: "Total Vote", value: "\(Double(detailVM.movieDetail.value.voteCount).roundedWithAbbreviations)"))
        }
        
        if detailVM.movieDetail.value.popularity > 0 {
            arrTitleValueData.append(TitleValueModel(title: "Popularity", value: "\(detailVM.movieDetail.value.popularity.roundedWithAbbreviations)"))
        }
        
        if detailVM.movieDetail.value.budget > 0 {
            arrTitleValueData.append(TitleValueModel(title: "Budget", value: "$\(Double(detailVM.movieDetail.value.budget).roundedWithAbbreviations)") )
        }
        
        if detailVM.movieDetail.value.revenue > 0 {
            arrTitleValueData.append(TitleValueModel(title: "Revenue", value: "$\(Double(detailVM.movieDetail.value.revenue).roundedWithAbbreviations)"))
        }
        
        
        updateTblHeight()
    }
}
