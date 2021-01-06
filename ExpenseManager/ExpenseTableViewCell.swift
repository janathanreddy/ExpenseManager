//
//  ExpenseTableViewCell.swift
//  ExpenseManager
//
//  Created by Janarthan Subburaj on 06/01/21.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var Amount: UILabel!
    @IBOutlet weak var PayerLabel: UILabel!
    @IBOutlet weak var PaymentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        Amount?.layer.cornerRadius = (Amount?.frame.size.height)!/2.0
        Amount?.layer.borderColor = UIColor.black.cgColor
        Amount?.layer.borderWidth = 0.8
        Amount?.layer.masksToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
