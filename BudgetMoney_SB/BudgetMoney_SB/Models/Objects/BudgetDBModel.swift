//
//  BudgetDBModel.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2023/1/12.
//

import UIKit
import CoreData

class BudgetDBModel: NSObject {
    
    let budgetDB = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override init() {
        super.init()
    }
    
    func insertObjects(_ amount: Int64,_ time: Date) {

        let budget = NSEntityDescription.insertNewObject(forEntityName: "Budget", into: self.budgetDB) as! Budget

        budget.budget_amount = amount
        budget.time = time
        do {
            try budgetDB.save()
            //成功 拋出callback 提示成功
        } catch {
            print("data insert error")
        }
    }
    
    //資料刪除
    func deleteObject(at budget: Budget) {
        
        do {
            budgetDB.delete(budget)
            try self.budgetDB.save()
      
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }
    }
        
    //資料修改
    func modifyObject(_ amount: Int64,_ date: Date,_ dateStr: String, show: @escaping(_ succ: Bool) -> Void)  {
        //date formatter: yyyy/MM
        var succ: Bool = false
        let request = NSFetchRequest<Budget>(entityName: "Budget")
        do {
            let results = try self.budgetDB.fetch(request)
            
            let compare = DateFormatter()
            compare.dateFormat = "yyyy/MM"
            //篩選結果
            for result in results {
                let dTime = compare.string(from: result.time!)
                if dTime == dateStr {
                    result.budget_amount = amount
                    succ = true
                }
            }
            
            try self.budgetDB.save()
            show(succ)
        } catch let error {
            dump(error)
        }
    }
    
    //資料查詢
    func showObjects(_ time: String) -> Int64{
        var budgetNum: Int64 = 0
        let request = NSFetchRequest<Budget>(entityName: "Budget")
        do {
            let results = try budgetDB.fetch(request)
            
            let compare = DateFormatter()
            compare.dateFormat = "yyyy/MM"
            //篩選結果
            for result in results {
                let dTime = compare.string(from: result.time!)
                if dTime == time {
                    budgetNum = result.budget_amount
                }
            }
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }
        return budgetNum
    }
    
    func checkBudget(_ time: String) -> Bool {
        var check: Bool = false
        let request = NSFetchRequest<Budget>(entityName: "Budget")
       
        do {
            let results = try budgetDB.fetch(request)
            
            let compare = DateFormatter()
            compare.dateFormat = "yyyy/MM"
            //篩選結果
            for result in results {
                let dTime = compare.string(from: result.time!)
                if dTime == time {
                    check = true // true 代表已經有了 -> 則下次新增同樣的需要走修改路線
                }
            }
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }
        
        return check
    }

}
