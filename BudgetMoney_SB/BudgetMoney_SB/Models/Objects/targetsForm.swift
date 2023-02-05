//
//  targetsForm.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/4.
//

import Foundation

class TargetsForm: NSObject {
    var desc: String?
    var name: String?
    
    override init() {
        super.init()
    }
    
    convenience init(desc: String, name: String) {
        self.init()

        self.desc = desc
        self.name = name
    }
}
