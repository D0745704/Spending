//
//  InsertTargetsViewController.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/2.
//

import UIKit

class InsertTargetsViewController: UIViewController {

    @IBOutlet weak var targetName: UITextField!
    @IBOutlet weak var targetDesc: UITextField!
    @IBOutlet weak var submit: UIButton!
    
    @IBOutlet weak var insertionView: UIView!
    private let dbModel = DBModel() //insert
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        targetName.delegate = self
        targetDesc.delegate = self
        configView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        refreshMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    func configView() {
        self.insertionView.layer.cornerRadius = 12
        self.submit.layer.cornerRadius = 18
        
        targetName.placeholder = "存錢目標"
        targetDesc.placeholder = "備註、價錢"
    }

    @IBAction func isSubmitted(_ sender: Any) {
        if targetName.text != "" {
            
            dbModel.insertObjects(name: targetName.text!, desc: targetDesc.text ?? "")
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func isTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}

extension InsertTargetsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let countOfWords = textField.text!.count - range.length + string.count
        if countOfWords > 10 {
            return false
        }
        //wordsCountingLabel.text = "\(countOfWords) / 10"
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
