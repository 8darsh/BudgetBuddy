//
//  HomeViewController.swift
//  BudgetBud
//
//  Created by Adarsh Singh on 23/09/23.
//

import UIKit

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
        incomeSetter = 60000
        incomeTitleLabel.text = String(incomeSetter)
        self.expense = DatabaseHelper.shared.getData()
        self.tableView.reloadData()
    }
    
    @objc func addExpense(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InputExpenseViewController") as! InputExpenseViewController
        
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
            cell?.amountLbl.textColor = .systemRed

            cell?.amountLbl.text = "-₹\(expense[indexPath.row].amount ?? "")"
//            currentBalanceSetter = incomeSetter - expenseSetter
//            currentBalanceTitleLabel.text = String(currentBalanceSetter)
        }else{
            cell?.amountLbl.textColor = .systemGreen

            cell?.amountLbl.text = "+₹\(expense[indexPath.row].amount ?? "")"
//            incomeSetter += expenseSetter
//            incomeTitleLabel.text = String(incomeSetter)
//            currentBalanceSetter = incomeSetter + expenseSetter
//            currentBalanceTitleLabel.text = String(currentBalanceSetter)
        }
        
        cell?.expenseImage.image = UIImage(systemName: "person.fill")
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
