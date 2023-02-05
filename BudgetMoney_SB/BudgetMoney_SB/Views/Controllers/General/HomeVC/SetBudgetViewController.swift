//
//  SetBudgetViewController.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2023/1/8.
//

import UIKit

class SetBudgetViewController: UIViewController {
    ///大致上就是數字鍵盤 跟一些描述即可
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var amount: UILabel!
    ///1~3
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    ///4~6
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    ///7~0
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    @IBOutlet weak var nihil: UIButton!
    ///others
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var submit: UIButton!
    
    @IBOutlet weak var tintText: UILabel!
    
    private var numberArray: [UIButton] = []
    
    var budgetVM = SetBudgetViewModel()
    var time: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initText()
        numberConfig()
        numberImageConfig()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        refreshMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    private func initText() {
        tintText.text = "預算每個月需設定一次"
    }
    
    private func numberConfig() {
        
        numberArray.append(self.nihil)
        
        numberArray.append(self.one)
        numberArray.append(self.two)
        numberArray.append(self.three)
        
        numberArray.append(self.four)
        numberArray.append(self.five)
        numberArray.append(self.six)
        
        numberArray.append(self.seven)
        numberArray.append(self.eight)
        numberArray.append(self.nine)
        
        numberArray.append(self.delete)
        numberArray.append(self.submit)
    }
    
    private func numberImageConfig() {
        for numberImage in numberArray {
            numberImage.layer.cornerRadius = 10
            numberImage.backgroundColor = UIColor(named: "SetBudgetButton")
            numberImage.tintColor = .label
        }
    }
    
    @IBAction func isTappedNumber(_ sender: UIButton) {
        //詳細邏輯 放在VM
        if amount.text!.count < 9 {
            
            if Int(amount.text!) == 0 {
                amount.text = ""
            }
            
            switch sender {
            case one:
                amount.text = amount.text! + "1"
            case two:
                amount.text = amount.text! + "2"
            case three:
                amount.text = amount.text! + "3"
            case four:
                amount.text = amount.text! + "4"
            case five:
                amount.text = amount.text! + "5"
            case six:
                amount.text = amount.text! + "6"
            case seven:
                amount.text = amount.text! + "7"
            case eight:
                amount.text = amount.text! + "8"
            case nine:
                amount.text = amount.text! + "9"
            case nihil:
                if Int(amount.text!) != 0 {
                    amount.text = amount.text! + "0"
                }
            default:
                break
            }
        }
    }
    
    @IBAction func isTappedDelete(_ sender: Any) {
        amount.text = String(amount.text!.dropLast())
        
        if amount.text!.isEmpty {
            amount.text = "0"
        }
    }
    //call db 來新增資料
    @IBAction func isTapped(_ sender: Any) {
        
        if amount.text != "0" {
            let tempAmount = Int64(amount.text!)!
            budgetVM.setBudget(tempAmount, time) { succ in
                //跳出提示
            }
            
            self.dismiss(animated: false)
        }
    }
}
