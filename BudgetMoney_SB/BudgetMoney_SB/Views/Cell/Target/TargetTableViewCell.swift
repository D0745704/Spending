//
//  TargetTableViewCell.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/2.
//

import UIKit

class TargetTableViewCell: UITableViewCell {

    @IBOutlet weak var targetName: UILabel!
    @IBOutlet weak var targetDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
