//
//  TwoLableDetailTVC.swift
//  KeyurApp
//
//  Created by Keyur on 11/02/23.
//

import UIKit

class TwoLableDetailTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : TitleValueModel) {
        titleLbl.text = dict.title
        valueLbl.text = dict.value
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
