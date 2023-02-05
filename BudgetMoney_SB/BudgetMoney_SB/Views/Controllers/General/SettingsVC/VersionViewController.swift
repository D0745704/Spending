//
//  VersionViewController.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2023/2/1.
//

import UIKit

class VersionViewController: UIViewController {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var contentText: UILabel!
    
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
        content.text = "預計更新"
        contentText.text = " - 圖表\n   可以看見使用者的消費者花費分佈\n\n - 推播\n   一天提醒一次記帳,且可以設定時間,當然也可以關閉\n\n - 其它語言\n   暫時不會"
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
