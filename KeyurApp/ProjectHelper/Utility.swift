//
//  Utility.swift
//  KeyurApp
//
//  Created by Keyur on 11/02/23.
//

import Foundation
import UIKit
import SDWebImage

func showAlert(_ title: String, _ message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    
    UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
}

//MARK: - downloadCachedImage
extension UIImageView{
    func downloadCachedImage(urlString: String){
        let options: SDWebImageOptions = [.scaleDownLargeImages, .continueInBackground, .avoidAutoSetImage]
        self.sd_setImage(with: URL(string: urlString), placeholderImage: nil, options: options) { (image, _, cacheType,_ ) in
            //self.sainiRemoveLoader()
            guard image != nil else {
                //self.sainiRemoveLoader()
                return
            }
            guard cacheType != .memory, cacheType != .disk else {
                self.image = image
                //self.sainiRemoveLoader()
                return
            }
            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                //self.sainiRemoveLoader()
                self.image = image
                return
            }, completion: nil)
        }
    }
}

func getSecondsToTime(_ minute: Int) -> String {
    let seconds = minute*60
    let hour = seconds/3600
    let min = (seconds % 3600) / 60
    let secs = (seconds % 3600) % 60
    var strTime = ""
    if hour > 0 {
        strTime = "\(hour)" + ((hour > 1) ? "hrs" : "hr")
    }
    if min > 0 {
        strTime += (strTime != "" ? " " : "") + "\(min)" + ((min > 1) ? "mins" : "min")
    }
    if secs > 0 {
        strTime += (strTime != "" ? " " : "") + "\(secs)" + ((secs > 1) ? "secs" : "sec")
    }
    return strTime
}

func displayFlotingValue(_ price : Double) -> String
{
    var finalValue = String(format: "%.1f", Float(price))
    if finalValue.contains(".0") {
        finalValue = finalValue.replacingOccurrences(of: ".0", with: "")
    }
    return finalValue
}

func getReleaseDate(strDate : String) -> String {
    if strDate == "" {
        return ""
    }
    let dateFormat = DateFormatter.init()
    dateFormat.dateFormat = "yyyy-MM-dd"
    let date = dateFormat.date(from: strDate)!
    dateFormat.dateFormat = "MMM d, yyyy"
    return dateFormat.string(from: date)
}

extension Double {
    var roundedWithAbbreviations: String {
        let number = self
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(displayFlotingValue(million*10/10))M"
        }
        else if thousand >= 1.0 {
            return "\(displayFlotingValue(thousand*10/10))K"
        }
        else {
            return "\(self)"
        }
    }
}
