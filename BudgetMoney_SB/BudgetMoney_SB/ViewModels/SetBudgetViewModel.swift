//
//  SetBudgetViewModel.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2023/1/12.
//

import Foundation

class SetBudgetViewModel {
    
    var budgetDB = BudgetDBModel()
    
    func setBudget(_ amount: Int64,_ time: String, show: @escaping(_ succ: Bool) -> Void) {
        // 如果比對時間後 重複？
        let compare: Bool = self.compareTime(time)
        
        if compare == false {
            let date = Date()
            budgetDB.insertObjects(amount, date)
        } else {
            let timeDate = stringToDate(time)
            budgetDB.modifyObject(amount, timeDate, time) { succ in
                show(succ)
            }
        }
    }
    
    private func compareTime(_ time: String) -> Bool {
        budgetDB.checkBudget(time)
    }
    
    private func stringToDate(_ date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        let time = formatter.date(from: date)!
        
        return time
    }
}
