//
//  ExpenseEmptyViewController.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2023/1/21.
//

import UIKit

class ExpenseEmptyViewController: UIViewController {

    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var footerView: UIView!
    
    var category: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func initView() {
        categoryTitle.text = category
        subtitle.text = "目前沒有資料"
        footerView.layer.cornerRadius = 16
    }
    
    @IBAction func cancelsPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
