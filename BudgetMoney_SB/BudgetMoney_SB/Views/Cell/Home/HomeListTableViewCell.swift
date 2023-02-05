//
//  HomeListTableViewCell.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/6.
//

import UIKit

class HomeListTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionIcon: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var spend: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        changeColor(enabled: highlighted)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        changeColor(enabled: selected)
    }
    
    func changeColor(enabled: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.contentView.backgroundColor = enabled ? UIColor(red: 0, green: 0, blue: 255, alpha: 0.3) : .clear
        }
    }

}
