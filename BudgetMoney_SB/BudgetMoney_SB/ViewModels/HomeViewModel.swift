//
//  HomeViewModel.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/21.
//

import Foundation

class HomeViewModel {
    //public var
    let expenseDB = ExpenseDBModel()
    let budgetDB = BudgetDBModel()
    
    func getToday() -> Int {
        let today = Date()
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: today)
        let month = dateComponents.month!
        
        return month
    }
    
    func getTodayString() -> String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        
        let todayStr = formatter.string(from: today)
        return todayStr
    }
    
    func getDayString(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        
        let todayStr = formatter.string(from: time)
        return todayStr
    }
    
    func getExpenseNum(_ time: String, _ category: String) -> Int {
        let numArr = expenseDB.showObjects(time, category)
        return numArr.count
    }
    
    func getThisMonthTotalSpend(_ time: String) -> Int64 {
        let expense = expenseDB.showObjects(time)
        var sum: Int64 = 0
        
        expense.forEach { index in
            sum += index.amount
        }
        
        return sum
    }
    func getExpenseTotalSpend(_ time: String, _ category: String) -> Int64 {
        let expense = expenseDB.showObjects(time, category)
        var sum: Int64 = 0
        
        expense.forEach { index in
            sum += index.amount
        }
        
        return sum
    }
    
    func getBudgetNum(_ time: String) -> Int64 {
        let num = budgetDB.showObjects(time)
        
        return num
    }
    // MARK: - 控制時間
    func getTempTime(_ time: String) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        let newTime = formatter.date(from: time)!
        return newTime
    }
    
    func getMonthValue(_ time: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        
        let t = formatter.string(from: time)
        //擷取月份字串
        let start = t.index(t.startIndex, offsetBy: 5)
        let end = t.index(t.endIndex, offsetBy: 0)
        let range = start ..< end
        let month: Int = Int(t[range])!
        return month
    }
    
    func getYearValue(_ time: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        let year = Int(formatter.string(from: time))!
        return year
    }
    
    func addOrSubtractMonth(_ time: Date, month: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: month, to: time)!
    }
    
    func setMonthToChinese(month: Int, _ year: String) -> String{
        
        var monthStr = ""
        
        switch month {
        case 1:
            monthStr = "\(year) 一月"
        case 2:
            monthStr = "\(year) 二月"
        case 3:
            monthStr = "\(year) 三月"
        case 4:
            monthStr = "\(year) 四月"
        case 5:
            monthStr = "\(year) 五月"
        case 6:
            monthStr = "\(year) 六月"
        case 7:
            monthStr = "\(year) 七月"
        case 8:
            monthStr = "\(year) 八月"
        case 9:
            monthStr = "\(year) 九月"
        case 10:
            monthStr = "\(year) 十月"
        case 11:
            monthStr = "\(year) 十一月"
        case 12:
            monthStr = "\(year) 十二月"
        default:
            print("error")
        }

        return monthStr
    }
}
