//
//  ExpenseListViewModel.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2023/1/1.
//

import Foundation

class ExpenseListViewModel {
    
    var expenseModel = ExpenseDBModel()
    var days: [String] = []
    /// 取得日期數量
    func getAmountOfDate(_ category: String) -> Array<String> {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        let time = formatter.string(from: date)
        let dateArr = expenseModel.getMonthAndDay(time, category)
        
        return dateArr
    }
    
    func getExpenseData(_ category: String) -> Array<Expense>{
        var expenseList: [Expense] = []
        let date = Date() //改成當前選擇的年月份
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy/MM"
        let time = formatter.string(from: date)
        expenseList = expenseModel.showObjects(time, category)
         
        return expenseList
    }

    func dateToString(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        let str = formatter.string(from: time)
        
        return str
    }
    
    //MARK: - 刪除
    func delete(at expense: Expense) {
        expenseModel.deleteObject(at: expense)
    }
}
