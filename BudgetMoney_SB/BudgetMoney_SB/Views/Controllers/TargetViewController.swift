//
//  TargetViewController.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/2.
//

import UIKit

class TargetViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    private let targetVM = TargetViewModel()
    
    var budgetList: [Goal] = []
    var test: [Target] = [] // 整合用
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        refreshMediator.instance.setListener(self)
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        showTargetList()
        addLongPress()
    }
    
    func addLongPress() {
        
        let longPress = UILongPressGestureRecognizer(target: self,action: #selector(handleLongPress(sender:)))
        tableview.addGestureRecognizer(longPress)
    }
    
    @objc
    private func handleLongPress(sender: UILongPressGestureRecognizer) {

        if sender.state == .began {
            let touchPoint = sender.location(in: tableview)
            if let indexPath = tableview.indexPathForRow(at: touchPoint) {
                dump(indexPath.item)

                writeTargetAlert(at: indexPath, type: "修改", alertTitle: "修改目標")
            }
        }
    }

    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showInsertView(_ sender: Any) {
        showInsertPopupView()
    }
    
    
    func showInsertPopupView() {
        
        let insertTargetsVC = self.storyboard?.instantiateViewController(withIdentifier: "InsertVC") as! InsertTargetsViewController
        insertTargetsVC.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                
        let rootNav = UINavigationController(rootViewController: insertTargetsVC)
        rootNav.modalPresentationStyle = .fullScreen
        rootNav.modalPresentationStyle = .custom
        self.present(rootNav, animated: false)
    }

    private func showTargetList() {
        self.budgetList = targetVM.getDBData()

        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}

extension TargetViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - TableView區
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.budgetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TargetCell", for: indexPath) as? TargetTableViewCell else {
            return UITableViewCell()
        }
        
        cell.targetName.text = self.budgetList[indexPath.item].name
        cell.targetDesc.text = self.budgetList[indexPath.item].desc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            targetVM.deleteTarget(at: budgetList[indexPath.row])
            //closure 確認成功
            self.budgetList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}

extension TargetViewController: refreshListener {
    //MARK: - 重新整理用
    func popoverDismissed() {
        self.navigationController?.dismiss(animated: true, completion: nil)
        self.budgetList = targetVM.getDBData()

        tableview.reloadData()
    }
}

extension TargetViewController {
    //MARK: - Alert區
    func writeTargetAlert(at indexPath: IndexPath, type: String, alertTitle: String, actionHandler: ((_ textFields: [UITextField]?) -> Void)? = nil) {
        let alert = UIAlertController.init(
            title: "修改\(self.budgetList[indexPath.item].name ?? "")",
            message: "",
            preferredStyle: .alert
        )
        
        for index in 0...1 {
            alert.addTextField { (textField: UITextField) in
                if index == 0 {
                    textField.placeholder = type + "目標"
                }else if index == 1 {
                    textField.placeholder = type + "備註"
                }
            }
        }
        alert.addAction(UIAlertAction.init(title: "確定", style: .default, handler: {(action: UIAlertAction) in
            DispatchQueue.main.async {
                let name = alert.textFields![0].text
                let desc = alert.textFields?[1].text
                
                self.targetVM.modifyTarget(at: indexPath, name!, desc ?? "") { list in
                    if list == true {
                        self.tableview.reloadData()
                    }
                    else {
                        self.showDuplicateAlert()
                    }
                }
            }
        }))
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { _ in
            DispatchQueue.main.async {
                
            }
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: {
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        })
    }
    
    func showDuplicateAlert() {
        let duplicateAlert = UIAlertController.init(
            title:          "資料已存在",
            message:        "",
            preferredStyle: .alert
        )
        let finishAction = UIAlertAction.init(title: "好吧", style: .default)
        duplicateAlert.addAction(finishAction)
        self.present(duplicateAlert, animated: true, completion: {
            self.tableview.reloadData()
        })
    }
}

//MARK: - 進度規劃
/*
 1.基本功能完成 需進行排版
 2.外觀設計
 3.
 */
