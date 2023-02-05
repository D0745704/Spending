//
//  ExpenseDetailViewController.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/6.
//

import UIKit

class ExpenseDetailViewController: UIViewController {

    private let expenseViewModel = ExpenseListViewModel()
    @IBOutlet weak var categoryTitle: UILabel!
    
    var expenseList: [Expense] = []
    var dateList: [String] = []
    var expenseListClassified: [[Expense]] = []
    var category: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initExpenseList()
        initDateList()
        classifyExpenseList()
        
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
        refreshMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    private func initExpenseList() {
        categoryTitle.text = category
        tableView.layer.cornerRadius = 16
        expenseList = expenseViewModel.getExpenseData(category)
    }
    
    private func initDateList() {
        dateList = expenseViewModel.getAmountOfDate(category)
    }
    
    private func classifyExpenseList() {
        var tempArr: [Expense] = []
        
        dateList.forEach { index in
            for index2 in 0 ... expenseList.count-1 {
                //date to string
                let day: String = expenseViewModel.dateToString(expenseList[index2].date!)
                if day == index {
                    tempArr.append(expenseList[index2])
                }
            }
            expenseListClassified.append(tempArr)
            tempArr.removeAll()
        }
        expenseList.removeAll()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension ExpenseDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseListClassified[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dateList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateList[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseListVC", for: indexPath) as? ExpenseTableViewCell else {
            return UITableViewCell()
        }
        
        cell.name.text = expenseListClassified[indexPath.section][indexPath.item].title
        cell.amount.text = String(expenseListClassified[indexPath.section][indexPath.item].amount) + " 元"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            expenseViewModel.delete(at: expenseListClassified[indexPath.section][indexPath.row])
            //closure 確認成功
            self.expenseListClassified[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
