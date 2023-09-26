//
//  HomeViewController.swift
//  BudgetBud
//
//  Created by Adarsh Singh on 23/09/23.
//

import UIKit
import CoreData
import LocalAuthentication
class HomeViewController: UIViewController {
    
    
    @IBOutlet var totalIncome: UILabel!
    
    @IBOutlet var monthlyIncome: UILabel!
    
    @IBOutlet var monthlyExpenses: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var monthYear: UILabel!
    
    var expenseSetter = Int()
    var incomeSetter = Int()
    var currentBalanceSetter = Int()
    
    @IBOutlet var expensesTitleLbl: UILabel?{
        didSet{
            expensesTitleLbl?.text = String(expenseSetter)
        }
    }
    
    @IBOutlet var incomeTitleLabel: UILabel!
    
    @IBOutlet var currentBalanceTitleLabel: UILabel!
    

    var expense = [Expense]()
   
    var countIndex = Int()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.tableView.layer.cornerRadius = 20
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM  yyyy"
        monthYear.text = dateFormatter.string(from: Date())
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addExpense))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        balance = DatabaseHelper.shared.getDataBalance()
        self.expensesTitleLbl?.text = UserDefaults.standard.string(forKey: "expenseAmount")
        self.incomeTitleLabel.text = UserDefaults.standard.string(forKey: "income")
        self.currentBalanceTitleLabel.text = UserDefaults.standard.string(forKey: "currentBalance")
        self.expense = DatabaseHelper.shared.getData()
        self.tableView.reloadData()
    }
    
    @objc func addExpense(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InputExpenseViewController") as! InputExpenseViewController
        vc.completion = {
            dict in
            if vc.switchTransaction.isOn{
                self.incomeSetter = Int(UserDefaults.standard.string(forKey: "income")!) ?? 0
                self.expenseSetter = Int(UserDefaults.standard.string(forKey: "expenseAmount")!) ?? 0
                self.expenseSetter += dict["expenseAmount"] as! Int
               
            }else{
                self.expenseSetter = Int(UserDefaults.standard.string(forKey: "expenseAmount")!) ?? 0
                self.incomeSetter = Int(UserDefaults.standard.string(forKey: "income")!) ?? 0
                self.incomeSetter +=  dict["expenseAmount"] as! Int
                
                
            }
        
        
            self.currentBalanceSetter = (self.incomeSetter) - self.expenseSetter
            UserDefaults.standard.setValue(String(self.currentBalanceSetter), forKey: "currentBalance")
            UserDefaults.standard.setValue(String(self.expenseSetter), forKey: "expenseAmount")
            UserDefaults.standard.setValue(String(self.incomeSetter), forKey: "income")
//            var balanceDic:([String:String]) = ([
//                "currentBalance":String(self.currentBalanceSetter),
//                "expenseAmount":String(self.expenseSetter),
//                "income":String(self.incomeSetter),
//            ])
//            self.countIndex += 1

           
        }

        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expense.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeExpenseTableViewCell
        
        let vc = self.storyboard?.instantiateViewController(identifier: "InputExpenseViewController") as! InputExpenseViewController
        cell?.expenseDate.text = expense[indexPath.row].date
        cell?.expenseTitle.text = expense[indexPath.row].title
        
        if expense[indexPath.row].type{
            cell?.amountLbl.textColor = .systemOrange
            
            cell?.amountLbl.text = "-₹\(expense[indexPath.row].amount ?? "")"
        }else{
            cell?.amountLbl.textColor = .systemGreen

            cell?.amountLbl.text = "+₹\(expense[indexPath.row].amount ?? "")"
        }

        if expense[indexPath.row].title == "Food"{
            cell?.expenseImage.image = UIImage(systemName: "fork.knife")
        }
        else if expense[indexPath.row].title == "Shopping"{
            cell?.expenseImage.image = UIImage(systemName: "bag")
        }
        else if expense[indexPath.row].title == "Essentials"{
            cell?.expenseImage.image = UIImage(systemName: "takeoutbag.and.cup.and.straw")
        }
        else if expense[indexPath.row].title == "Travel"{
            cell?.expenseImage.image = UIImage(systemName: "airplane")
        }
        else if expense[indexPath.row].title == "Drinks"{
            cell?.expenseImage.image = UIImage(systemName: "waterbottle")
        }
        else if expense[indexPath.row].title == "Bonus"{
            cell?.expenseImage.image = UIImage(systemName: "indianrupeesign")
        }else if expense[indexPath.row].title == "Rent"{
            cell?.expenseImage.image = UIImage(systemName: "indianrupeesign")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
           
            expense = DatabaseHelper.shared.deletData(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InputExpenseViewController") as!
        InputExpenseViewController
        
        vc.expenseDetails = expense[indexPath.row]
        vc.index = indexPath.row
        vc.isUpdate = true
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController{
    
    
}
