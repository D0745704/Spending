//
//  AddExpenseViewController.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/25.
//

import UIKit

class AddExpenseViewController: UIViewController {

    //上排
    @IBOutlet weak var food: UIButton!
    @IBOutlet weak var cloth: UIButton!
    @IBOutlet weak var house: UIButton!
    @IBOutlet weak var entertainment: UIButton!
    //下排
    @IBOutlet weak var transport: UIButton!
    @IBOutlet weak var medical: UIButton!
    @IBOutlet weak var educate: UIButton!
    @IBOutlet weak var other: UIButton!
    //Date & Desc
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var desc: UITextField!
    //Number Zone
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    
    @IBOutlet weak var nihil: UIButton! // 0
    //delete
    @IBOutlet weak var delete: UIButton!
    //Submit
    @IBOutlet weak var submit: UIButton!
    //金額
    @IBOutlet weak var amount: UILabel!
    //介面
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var numberView: UIView!
    
    var input: Int {
        get {
            return Int(amount.text!)!
        }
        set {
            amount.text = String(newValue)
        }
    }
    
    private let budgetDataModel = ExpenseDBModel()
    
    private var buttonArray: [UIButton] = []
    private var numberArray: [UIButton] = []
    
    private var category: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBackgroundColor()
        
        buttonConfig()
        categoryConfig()
        numberConfig()
        numberImageConfig()
        leftConfig()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        refreshMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    private func initBackgroundColor() {
        infoView.backgroundColor = UIColor(named: "background3")
        amountView.backgroundColor = UIColor(named: "background4")
        numberView.backgroundColor = UIColor(named: "NumberArea")
        
    }
    
    private func buttonConfig() {
        
        buttonArray.append(self.food)
        buttonArray.append(self.cloth)
        buttonArray.append(self.house)
        buttonArray.append(self.entertainment)
        
        buttonArray.append(self.transport)
        buttonArray.append(self.medical)
        buttonArray.append(self.educate)
        buttonArray.append(self.other)
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
        
    }
    
    private func categoryConfig() {
        
        if #available(iOS 15, *) {
            self.food.setImage(UIImage(systemName: "fork.knife"), for: .normal)
            self.food.setImage(UIImage(systemName: "fork.knife.fill"), for: .selected)
        } else {
            self.food.setImage(UIImage(systemName: "leaf"), for: .normal)
            self.food.setImage(UIImage(systemName: "leaf.fill"), for: .selected)
        }
        self.food.backgroundColor = .systemGray5
        self.food.layer.cornerRadius = 30
        
        if #available(iOS 15, *) {
            self.cloth.setImage(UIImage(systemName: "tshirt"), for: .normal)
            self.cloth.setImage(UIImage(systemName: "tshirt.fill"), for: .selected)
        } else {
            self.cloth.setImage(UIImage(systemName: "t.circle"), for: .normal)
            self.cloth.setImage(UIImage(systemName: "t.circle.fill"), for: .selected)
        }
        self.cloth.backgroundColor = .systemGray5
        self.cloth.layer.cornerRadius = 30
        
        self.house.setImage(UIImage(systemName: "house"), for: .normal)
        self.house.setImage(UIImage(systemName: "house.fill"), for: .selected)
        self.house.backgroundColor = .systemGray5
        self.house.layer.cornerRadius = 30
        
        if #available(iOS 15, *) {
            self.entertainment.setImage(UIImage(systemName: "circle.grid.cross.left.filled"), for: .normal)
            self.entertainment.setImage(UIImage(systemName: "circle.grid.cross.right.filled"), for: .selected)
        } else {
            self.entertainment.setImage(UIImage(systemName: "gamecontroller"), for: .normal)
            self.entertainment.setImage(UIImage(systemName: "gamecontroller.fill"), for: .selected)
        }
        self.entertainment.backgroundColor = .systemGray5
        self.entertainment.layer.cornerRadius = 30
        
        self.transport.setImage(UIImage(systemName: "bus"), for: .normal)
        self.transport.setImage(UIImage(systemName: "bus.fill"), for: .selected)
        self.transport.backgroundColor = .systemGray5
        self.transport.layer.cornerRadius = 30
        
        self.medical.setImage(UIImage(systemName: "cross.case.fill"), for: .normal)
        self.medical.setImage(UIImage(systemName: "cross.case.fill"), for: .selected)
        self.medical.backgroundColor = .systemGray5
        self.medical.layer.cornerRadius = 30
        
        self.educate.setImage(UIImage(systemName: "books.vertical.fill"), for: .normal)
        self.educate.setImage(UIImage(systemName: "books.vertical"), for: .selected)
        self.educate.backgroundColor = .systemGray5
        self.educate.layer.cornerRadius = 30
        
        if #available(iOS 16, *) {
            self.other.setImage(UIImage(systemName: "list.bullet.clipboard"), for: .normal)
            self.other.setImage(UIImage(systemName: "list.bullet.clipboard"), for: .selected)
        } else {
            self.other.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
            self.other.setImage(UIImage(systemName: "ellipsis.circle.fill"), for: .selected)
        }
        self.other.backgroundColor = .systemGray5
        self.other.layer.cornerRadius = 30
    }
    
    private func numberImageConfig() {
        for numberImage in numberArray {
            numberImage.layer.cornerRadius = 10
            numberImage.backgroundColor = UIColor(named: "AddExpenseButton")
            numberImage.tintColor = .label
        }
    }
    
    private func leftConfig() {
        self.delete.layer.cornerRadius = 10
        self.delete.backgroundColor = UIColor(named: "AddExpenseButton")
        self.delete.tintColor = .label
        self.submit.layer.cornerRadius = 10
        self.submit.backgroundColor = UIColor(named: "AddExpenseButton")
        self.submit.tintColor = .label
    }
    private func dateConfig() {
        //官方bug? 暫時跳過 能用就好...
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 年 MM 月 dd 日"
        
        let minm = DateComponents(calendar: Calendar.current, year: 2000, month: 1, day: 1)
        date.minimumDate = minm.date!
    }
    
    @IBAction func selectCategoryPressed(_ sender: UIButton) {
        
        for button in buttonArray {
            button.isSelected = false
            button.backgroundColor = .systemGray5
            button.tintColor = .black
        }
        
        sender.isSelected = true
        sender.backgroundColor = .black
        if #available(iOS 16, *) {
            sender.tintColor = .white
        }
        switch sender {
        case food:
            category = "餐飲"
        case cloth:
            category = "服飾"
        case house:
            category = "家居"
        case entertainment:
            category = "娛樂"
        case transport:
            category = "交通"
        case medical:
            category = "醫療"
        case educate:
            category = "學習"
        case other:
            category = "其它"
        default:
            break
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
        
        if category != "" || amount.text != "0"{
            let tempAmount = Int64(amount.text!)!
            let id = UUID().uuidString
            
            if desc.text != "" {
                budgetDataModel.insertObjects(category, tempAmount, desc.text ?? "某次的消費", date.date, id)
                self.dismiss(animated: false)
            } else {
                budgetDataModel.insertObjects(category, tempAmount, "某次的消費", date.date, id)
                self.dismiss(animated: false)
            }
        } else {
            //跳出提示訊息
        }
    }
    
}

extension UIViewController {

    //perhaps someday...
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
