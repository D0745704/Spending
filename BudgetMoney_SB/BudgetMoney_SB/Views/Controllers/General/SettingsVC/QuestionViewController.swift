//
//  QuestionViewController.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2023/2/6.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var rabbitImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textConfig()
        imageConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func textConfig() {
        titleLabel.text = "可能有的問題"
        contentLabel.text = " - 沒有收入\n   此APP目的在於控制預算,透過記錄總支出來控制花費,所以不會有記錄收入的功能\n\n - 可以修改或刪除資料嗎\n   左移可刪除,\"目標\"則有提供長按修改\n\n - 配色好醜\n   我盡力了"
    }
    
    private func imageConfig() {
        
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            rabbitImage.image = UIImage(named: "SettingImageLight")
        case .dark:
            rabbitImage.image = UIImage(named: "SettingImage")
        default:
            break
        }
    }
}
