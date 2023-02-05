//
//  TargetViewModel.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/21.
//

import Foundation

class TargetViewModel {
    
    private let dbModel = DBModel()
    
    
    func getDBData() -> Array<Goal>{
        let data = dbModel.showObjects()
        return data
    }
    
    func deleteTarget(at goal: Goal) {
        dbModel.deleteObject(at: goal)
    }
    
    func modifyTarget(at indexPath: IndexPath,_ target: String,_ desc: String?, show: @escaping(_ list: Bool) -> Void) {
        dbModel.modifyObject(at: indexPath, target: target, desc: desc) { list in
            show(list)
        }
    }
}
