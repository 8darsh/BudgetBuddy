//
//  ActivityTableViewCell.swift
//  BudgetBuddy
//
//  Created by Adarsh Singh on 24/09/23.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    @IBOutlet var expenseImage: UIImageView!
    
    @IBOutlet var expenseTitle: UILabel!
    
    @IBOutlet var expenseDate: UILabel!
    
    @IBOutlet var amountLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
