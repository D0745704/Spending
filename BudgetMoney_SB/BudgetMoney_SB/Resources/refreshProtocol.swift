//
//  refreshProtocol.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/18.
//

import Foundation

protocol refreshListener {
    func popoverDismissed()
}

class refreshMediator {
    /* Singleton */
    class var instance: refreshMediator {
        struct Static {
            static let instance: refreshMediator = refreshMediator()
        }
        return Static.instance
    }

    private var listener: refreshListener?

    private init() {

    }

    func setListener(_ listener: refreshListener) {
        self.listener = listener
    }

    func sendPopoverDismissed(modelChanged: Bool) {
        listener?.popoverDismissed()
    }
}
