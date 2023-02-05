//
//  SettingsViewController.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/2.
//

import UIKit

enum SettingSections: Int {
    case info = 0
    case version = 1
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case SettingSections.info.rawValue:
            return 2
        case SettingSections.version.rawValue:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
        case SettingSections.info.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! SettingInfoTableViewCell
            
            switch indexPath.row {
            case 0:
                cell.info.text = "下次更新"
            case 1:
                cell.info.text = "Q&A"
            default:
                cell.info.text = "--"
            }
            
            return cell
        case SettingSections.version.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VersionCell", for: indexPath) as! SettingVersionTableViewCell
            
            cell.versionTitle.text = "版本資訊"
            if let infoDictionary = Bundle.main.infoDictionary {
                let bundleVersion = infoDictionary["CFBundleShortVersionString"] as? String
                cell.version.text = bundleVersion ?? ""
            }
            
            return cell

        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "ContentVC") as! VersionViewController
                
                let rootNav = UINavigationController(rootViewController: detailVC)
                
                self.present(rootNav, animated: true)
            case 1:
                let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionVC") as! QuestionViewController
                
                let rootNav = UINavigationController(rootViewController: detailVC)
                
                self.present(rootNav, animated: true)
            default:
                break
            }
        default:
            break
        }
    }
}
