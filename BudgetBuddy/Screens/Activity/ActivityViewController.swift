//
//  ActivityViewController.swift
//  BudgetBud
//
//  Created by Adarsh Singh on 23/09/23.
//

import UIKit
import CoreData
class ActivityViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var expense = [Expense]()
   
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.expense = DatabaseHelper.shared.getData()
        self.tableView.reloadData()
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expense.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ActivityTableViewCell
        
        
        cell?.expenseDate.text = expense[indexPath.row].date
        cell?.expenseTitle.text = expense[indexPath.row].title
        if expense[indexPath.row].type{
            cell?.amountLbl.textColor = .systemOrange
            cell?.amountLbl.text = "-₹\(expense[indexPath.row].amount ?? "")"
        }else{
            cell?.amountLbl.textColor = .green
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
