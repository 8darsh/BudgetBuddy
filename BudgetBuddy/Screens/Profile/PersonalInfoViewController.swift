//
//  PersonalInfoViewController.swift
//  BudgetBuddy
//
//  Created by Adarsh Singh on 26/09/23.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    
    
    @IBOutlet var incomeTxt: UITextField!
    var completion: (([String:Any])->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addIncome))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        incomeTxt.text = UserDefaults.standard.string(forKey: "income")
    }
    @objc func addIncome(){
        guard let income = incomeTxt.text else {return}
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.incomeSetter = Int(income)!
        vc.expenseSetter = 0
        vc.currentBalanceSetter = 0
        UserDefaults.standard.setValue(vc.incomeSetter, forKey: "income")
        UserDefaults.standard.setValue(vc.expenseSetter, forKey: "expenseAmount")
        UserDefaults.standard.setValue(vc.currentBalanceSetter, forKey: "currentBalance")
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
