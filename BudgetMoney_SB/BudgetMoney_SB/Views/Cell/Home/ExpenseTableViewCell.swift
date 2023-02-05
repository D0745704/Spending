//
//  ExpenseTableViewCell.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/29.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
