//
//  HomeViewController.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/2.
//

import UIKit

enum Sections: Int {
    case food = 0
    case clothing = 1
    case housing = 2
    case entertainment = 3
    case transpotation = 4
    case medical = 5
    case educate = 6
    case other = 7
}


class HomeViewController: UIViewController {
    
    //UIView & UILabel Config
    @IBOutlet weak var footerView: UIView!
    //文字顯示花費部分
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var totalSpend: UILabel!
    @IBOutlet weak var remaining: UILabel!
    //控制月份按鈕
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    //設定預算按鈕 & 新增記帳按鈕
    @IBOutlet weak var setBudget: UIButton!
    @IBOutlet weak var addExpense: UIButton!
    //顯示預算
    @IBOutlet weak var budget: UILabel!
    //View
    @IBOutlet weak var budgetContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    private let homeVM = HomeViewModel()
    
    let sectionTitles: [String] = ["food","clothing","housing","entertainment","transpotation","medical", "educate","other"]
    
    var time: String = "" //formatter = "yyyy/MM"
    var year: String = ""
    
    var total: Int64 = 0
    var budgetNum: Int64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshMediator.instance.setListener(self)
        
        initTime()
        initButton()
        initTotalSpend()
        initBudget()
        initViewDesign()
        remainingNum()
        
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

    //MARK: 初始時間設定
    private func initTime() {
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        
        let t = formatter.string(from: date)
        self.time = t
        //擷取月份字串
        let start = t.index(t.startIndex, offsetBy: 5)
        let end = t.index(t.endIndex, offsetBy: 0)
        let range = start ..< end
        let monthValue: Int = Int(t[range])!
        //擷取年份字串
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        self.year = year
        self.month.text = homeVM.setMonthToChinese(month: monthValue, year)
    }
    
    //MARK: 初始金額設定
    private func initTotalSpend() {
        self.total = homeVM.getThisMonthTotalSpend(time)
        self.totalSpend.text = "總花費： NT$\(total)"
    }
    
    private func initBudget() {
        self.budgetNum = homeVM.getBudgetNum(time)
        self.budget.text = "\(budgetNum)"
    }
    
    private func remainingNum() {
        let remaining = budgetNum - total
        self.remaining.text = "剩餘： NT$\(remaining)"
    }
    
    //MARK: 初始按鈕設定
    private func initButton() {
        leftArrow.tintColor = .label
        rightArrow.tintColor = .label
        
        let today = homeVM.getTodayString()
        if time == today {
            rightArrow.isEnabled = false
        }
        if today == "2023/01" {
            leftArrow.isEnabled = false
        }
    }
    //MARK: - 介面設計
    private func initViewDesign() {
        budgetContainer.layer.cornerRadius = 12
        budgetContainer.backgroundColor = UIColor(named: "BudgetContainer")
        headerView.backgroundColor = UIColor(named: "MainBG")
    }
    //MARK: 重整資訊
    private func reloadExpenseData() {
        self.total = homeVM.getThisMonthTotalSpend(time)
        self.budgetNum = homeVM.getBudgetNum(time)
        
        self.totalSpend.text = "總花費： NT$\(total)"
        self.budget.text = "\(budgetNum)"
        self.remaining.text = "剩餘：NT$\(budgetNum - total)"
    }
    
    private func checkData(_ category: String) -> Bool {
        var result: Bool = false
        let num = homeVM.getExpenseNum(time, category)
        result = num == 0 ? false : true
        return result
    }
    
    //MARK: - 設定預算與新增花費
    @IBAction func setBudgetNum(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "BudgetVC") as?
            SetBudgetViewController {
            controller.time = time
            present(controller, animated: true)
        }
    }
    
    @IBAction func addButtonIsTapped(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "AddExpenseVC") as? AddExpenseViewController {
            present(controller, animated: true)
        }
    }
    
    //MARK: - 控制月份
    @IBAction func plusOneMonth(_ sender: Any) {
        let today = homeVM.getTodayString()
        let current = homeVM.getTempTime(self.time) // str to date
        
        let addOneMonth = homeVM.addOrSubtractMonth(current ,month: 1)
        // 更新time
        let newMonth = homeVM.getMonthValue(addOneMonth)
        let newYear = homeVM.getYearValue(addOneMonth)
        let monthStr = String(format: "%02d", newMonth)
        self.time = "\(newYear)/\(monthStr)"
        self.year = "\(String(newYear))"
        
        self.month.text = homeVM.setMonthToChinese(month: newMonth, self.year)
        // 控制月份上下限
        if time == today {
            rightArrow.isEnabled = false
        }
        if leftArrow.isEnabled == false {
            leftArrow.isEnabled = true
        }
        // reload
        reloadExpenseData()
        self.tableView.reloadData()
    }
    
    @IBAction func minusOneMonth(_ sender: Any) {
        //最低從2023/1開始
        let today = homeVM.getTodayString()
        let current = homeVM.getTempTime(self.time)
        
        let minusOneMonth = homeVM.addOrSubtractMonth(current ,month: -1)
        // 更新time
        let newMonth = homeVM.getMonthValue(minusOneMonth)
        let newYear = homeVM.getYearValue(minusOneMonth)
        let monthStr = String(format: "%02d", newMonth)
        self.time = "\(newYear)/\(monthStr)"
        self.year = "\(String(newYear))"
        
        self.month.text = homeVM.setMonthToChinese(month: newMonth, self.year)
        // 控制月份上下限
        if time != today {
            rightArrow.isEnabled = true
        }
        if time == "2023/01" {
            leftArrow.isEnabled = false
        }
        // 重整資訊
        reloadExpenseData()
        self.tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeListTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case Sections.food.rawValue:
            if #available(iOS 15, *) {
                cell.sectionIcon.image = UIImage(systemName: "fork.knife.circle")
            } else {
                cell.sectionIcon.image = UIImage(systemName: "leaf")
            }
            cell.title.text = "餐飲"
            cell.amount.text = "\(homeVM.getExpenseNum(time, "餐飲")) 個"
            cell.spend.text = "\(homeVM.getExpenseTotalSpend(time, "餐飲")) 元"
            
        case Sections.clothing.rawValue:
            if #available(iOS 15, *) {
                cell.sectionIcon.image = UIImage(systemName: "tshirt")
            } else {
                cell.sectionIcon.image = UIImage(systemName: "t.circle")
            }
            cell.title.text = "服飾"
            cell.amount.text = "\(homeVM.getExpenseNum(time, "服飾")) 個"
            cell.spend.text = "\(homeVM.getExpenseTotalSpend(time, "服飾")) 元"
            
        case Sections.housing.rawValue:
            cell.sectionIcon.image = UIImage(systemName: "house")
            cell.title.text = "家居"
            cell.amount.text = "\(homeVM.getExpenseNum(time, "家居")) 個"
            cell.spend.text = "\(homeVM.getExpenseTotalSpend(time, "家居")) 元"
            
        case Sections.entertainment.rawValue:
            if #available(iOS 15, *) {
                cell.sectionIcon.image = UIImage(systemName: "circle.grid.cross.left.filled")
            } else {
                cell.sectionIcon.image = UIImage(systemName: "gamecontroller")
            }
            cell.title.text = "娛樂"
            cell.amount.text = "\(homeVM.getExpenseNum(time, "娛樂")) 個"
            cell.spend.text = "\(homeVM.getExpenseTotalSpend(time, "娛樂")) 元"

        case Sections.transpotation.rawValue:
            cell.sectionIcon.image = UIImage(systemName: "bus.fill")
            cell.title.text = "交通"
            cell.amount.text = "\(homeVM.getExpenseNum(time, "交通")) 個"
            cell.spend.text = "\(homeVM.getExpenseTotalSpend(time, "交通")) 元"

        case Sections.medical.rawValue:
            cell.sectionIcon.image = UIImage(systemName: "cross.case.fill")
            cell.title.text = "醫療"
            cell.amount.text = "\(homeVM.getExpenseNum(time, "醫療")) 個"
            cell.spend.text = "\(homeVM.getExpenseTotalSpend(time, "醫療")) 元"
            
        case Sections.educate.rawValue:
            cell.sectionIcon.image = UIImage(systemName: "books.vertical")
            cell.title.text = "學習"
            cell.amount.text = "\(homeVM.getExpenseNum(time, "學習")) 個"
            cell.spend.text = "\(homeVM.getExpenseTotalSpend(time, "學習")) 元"
            
        case Sections.other.rawValue:
            if #available(iOS 16, *) {
                cell.sectionIcon.image = UIImage(systemName: "list.bullet.clipboard")
            } else {
                cell.sectionIcon.image = UIImage(systemName: "ellipsis.circle")
            }
            cell.title.text = "其它"
            cell.amount.text = "\(homeVM.getExpenseNum(time, "其它")) 個"
            cell.spend.text = "\(homeVM.getExpenseTotalSpend(time, "其它")) 元"

        default:
            return UITableViewCell()
        }
        
        cell.sectionIcon.tintColor = .label
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        var category: String = ""
        
        switch indexPath.section {
            case Sections.food.rawValue:
                category = "餐飲"
            case Sections.clothing.rawValue:
                category = "服飾"
            case Sections.housing.rawValue:
                category = "家居"
            case Sections.entertainment.rawValue:
                category = "娛樂"
            case Sections.transpotation.rawValue:
                category = "交通"
            case Sections.medical.rawValue:
                category = "醫療"
            case Sections.educate.rawValue:
                category = "學習"
            case Sections.other.rawValue:
                category = "其它"
            default:
                category = "其它" //錯誤？
        }

        let trick: Bool = checkData(category)
        
        if trick == true {
            let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! ExpenseDetailViewController
            
            detailVC.category = category
            
            let rootNav = UINavigationController(rootViewController: detailVC)
            rootNav.modalPresentationStyle = .fullScreen
            self.present(rootNav, animated: true)

        } else {
            let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "EmptyVC") as! ExpenseEmptyViewController
            
            detailVC.category = category
            
            let rootNav = UINavigationController(rootViewController: detailVC)
            rootNav.modalPresentationStyle = .fullScreen
            self.present(rootNav, animated: true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addExpense.alpha = 1
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        addExpense.alpha = 1
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addExpense.alpha = 1
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scroll: CGFloat = scrollView.contentSize.height - scrollView.bounds.size.height
        let scrollOffset: CGFloat = -scrollView.contentOffset.y
            
        let percentage: CGFloat = scrollOffset / scroll
        addExpense.alpha = (percentage)
        
    }
}

extension HomeViewController: refreshListener {
    //MARK: - 重新整理用
    func popoverDismissed() {
        reloadExpenseData()
        tableView.reloadData()
    }
}
