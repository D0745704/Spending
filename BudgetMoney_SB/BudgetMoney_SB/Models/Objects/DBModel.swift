//
//  DBModel.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/4.
//

import Foundation

import UIKit
import CoreData

class DBModel: NSObject {
    //記錄查詢出來的結果
    var budgetList: [Goal] = []
    let budgetDB = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override init() {
        super.init()
    }
    
    func insertObjects(name: String, desc: String) {

        let budget = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: self.budgetDB) as! Goal

        budget.name = name
        budget.desc = desc

        do {
            
            try budgetDB.save()
            
        } catch {
            print("data insert error")
        }
    }
    
    //資料刪除
    func deleteObject(at goal: Goal) {
        
        do {
            budgetDB.delete(goal)
            try self.budgetDB.save()
      
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }
    }
        
    //資料修改
    func modifyObject(at indexPath: IndexPath, target: String, desc: String?, show: @escaping(_ list: Bool) -> Void)  {
      
        var list: Bool = false
        let request = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            let results = try self.budgetDB.fetch(request)
            // NSPredicated
            request.predicate = NSPredicate(format: "name CONTAINS %@ AND desc CONTAINS %@", target, desc ?? "")
            let duplicateData = try budgetDB.fetch(request)
            
            if duplicateData.isEmpty {
                results[indexPath.row].name = target
                results[indexPath.row].desc = desc ?? ""
                list = true
            }

            try self.budgetDB.save()
            show(list)
        } catch let error {
            dump(error)
        }
    }
    
    //資料查詢
    func showObjects() -> Array<Goal>{
        var budgetData: [Goal] = []
        let request = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            let results = try budgetDB.fetch(request)
            //篩選結果
            for result in results {
                budgetData.append(result)
            }
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }
        
        return budgetData
    }
    
    //MARK: - 其他功能
    
    //過濾地區
    func filtArea() -> [String] {
        
        var areaArr:[String] = []
        let request = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            let results = try budgetDB.fetch(request)
            results.forEach { result in
                //if result != nil {
                    //
                //}
            }
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }
        areaArr = areaArr.uniqued().sorted()
        return areaArr
    }
}


extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
//MARK: - filter用法
/*
# filter
let filterResults = results.filter{ result in
    let condition =
        result.area == data.area &&
        result.servTime == data.time &&
        result.addr == data.addr &&
        result.loc == data.location
    return condition
}
if filterResults.isEmpty {
    parking.area = data.area
    parking.servTime = data.time
    parking.addr = data.addr
    parking.loc = data.location
    parking.dataType = data.type!
    
} else {
    return false
}
 */
/*
 1. 物件導向 k
 2. filter 調整 k
 3. 新增 k 修改 k 刪除 查詢 都用物件處理
 4. 方法命名要有動詞開頭, 變數命名不可有動詞開頭 k
 */
