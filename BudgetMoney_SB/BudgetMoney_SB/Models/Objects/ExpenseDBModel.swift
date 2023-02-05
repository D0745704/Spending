//
//  BudgetDBModel.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/28.
//

import UIKit
import CoreData

class ExpenseDBModel: NSObject {

    let expenseDB = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override init() {
        super.init()
    }
    
    func insertObjects(_ category: String,_ amount: Int64,_ title: String,_ date: Date,_ id: String) {

        let expense = NSEntityDescription.insertNewObject(forEntityName: "Expense", into: self.expenseDB) as! Expense

        expense.category = category
        expense.amount = amount
        expense.title = title
        expense.date = date
        expense.expense_id = id

        do {
            try expenseDB.save()
            //成功 拋出callback 提示成功
        } catch {
            print("data insert error")
        }
    }
    
    //資料刪除
    func deleteObject(at expense: Expense) {
        
        do {
            expenseDB.delete(expense)
            try self.expenseDB.save()
      
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }
    }
    
    //資料查詢
    func showObjects(_ time: String) -> Array<Expense>{
        var budgetData: [Expense] = []
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        do {
            let results = try expenseDB.fetch(request)
            
            let compare = DateFormatter()
            compare.dateFormat = "yyyy/MM"
            //篩選結果
            for result in results {
                let dTime = compare.string(from: result.date!)
                if dTime == time {
                    budgetData.append(result)
                }
            }
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }
        
        return budgetData
    }

    func showObjects(_ time: String,_ category: String) -> Array<Expense>{
        var budgetData: [Expense] = []
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        do {
            let results = try expenseDB.fetch(request)
            
            let compare = DateFormatter()
            compare.dateFormat = "yyyy/MM"
            //篩選結果
            for result in results {
                let dTime = compare.string(from: result.date!)
                if dTime == time && category == result.category{
                    budgetData.append(result)
                }
            }
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }
        
        return budgetData
    }
    
    //MARK: - 其他功能
    
    //處理月份和時間
    func getMonthAndDay(_ time: String,_ category: String) -> Array<String>{
        var budgetDate: [String] = []
        
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        do {
            let results = try expenseDB.fetch(request)
            let formatter = DateFormatter()
            let compare = DateFormatter()
            formatter.dateFormat = "MM/dd"
            compare.dateFormat = "yyyy/MM"
            //篩選結果
            for result in results {
                let dTime = compare.string(from: result.date!)
                if dTime == time && category == result.category {
                    let day = formatter.string(from: result.date!)
                    budgetDate.append(day)
                }
            }
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }
        //filter
        budgetDate = budgetDate.uniqued().sorted()
        
        return budgetDate
        
    }
}
