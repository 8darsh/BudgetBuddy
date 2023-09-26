//
//  InputExpenseViewController.swift
//  BudgetBud
//
//  Created by Adarsh Singh on 23/09/23.
//

import UIKit
import iOSDropDown
class InputExpenseViewController: UIViewController {
    
    @IBOutlet var expenseTitleField: UITextField!
    
    @IBOutlet var expenseAmountField: UITextField!
    
    
    @IBOutlet var expenseDateTime: UIDatePicker!
    
    @IBOutlet var dateTime: UITextField!
    
    @IBOutlet var billImage: UIImageView!
    

    
    @IBOutlet var switchTransaction: UISwitch!
    
    @IBOutlet var creditDebitLabel: UILabel!
    
    
    
    @IBAction func datePickerBtn(_ sender: UIDatePicker) {
        dateTime.inputView = expenseDateTime
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM d, h:mm a"
        dateTime.text = dateFormatter.string(from: expenseDateTime.date)
    }
    
    var isUpdate = false
    var index = Int()
    var amountTxt = String()
    var isSaveBtnVisible = Bool()
    var imageHandle:String?
    var expenseDetails: Expense?
    var completion: (([String:Any]) -> Void)?
    var expenseAmount = Int()
    var currentBalance = Int()
    var income = Int()
    
    @IBOutlet var dropDownType: DropDown!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dropDownType.optionArray = ["Food","Shopping","Drinks","Essentials","Travel","Bonus","Rent"]
        self.dropDownType.optionIds = [1,2,3,4,5,6,7]
        self.dropDownType.didSelect { selectedText, index, id in
            self.expenseTitleField.text = "\(selectedText)"
        }
        self.dropDownType.hideOptionsWhenSelect = false

        self.expenseTitleField?.text = self.expenseDetails?.title
        self.expenseAmountField.text = self.expenseDetails?.amount
        self.dateTime.text = self.expenseDetails?.date
        let path = getDocumentDirectory().appending(path: expenseDetails?.image ?? "hehe")
        self.billImage.image = UIImage(contentsOfFile: path.path())
        
        if switchTransaction.isOn{
            creditDebitLabel.text = "Debited(-)"
        }else{
            creditDebitLabel.text = "Credited(+)"
        }

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(btnSave))
    }
    
    
    
    
    @IBAction func switchTransactionBtn(_ sender: UISwitch) {
        if sender.isOn{
            creditDebitLabel.text = "Debited(-)"
        }else{
            creditDebitLabel.text = "Credited(+)"
        }

        
    }
 
    
    

    
    

}

extension InputExpenseViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    
    @IBAction func addBillImageButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        let ac = UIAlertController(title: "Select Pics", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Gallery", style: .default){_ in
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true)
        })
        ac.addAction(UIAlertAction(title: "Camera", style: .default){ _ in
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true)
        })

        
        present(ac,animated: true)
        
       
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        isSaveBtnVisible = false
        
        guard let image = info[.editedImage] as? UIImage else {return}
        
        self.billImage.image = image
        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appending(path: imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
            
            imageHandle = imageName
//            if isUpdate{
//                DatabaseHelper.shared.editData(object: [
//                    "title":expenseTitleField.text!,
//                    "amount":"\(expenseAmountField.text!)",
//                    "image":imageName,
//                    "date":dateTime.text!,
//                    "type":switchTransaction.isOn
//                ], i: index)
//                isUpdate = false
//            }else{
//                DatabaseHelper.shared.save(object: [
//                    "title":expenseTitleField.text!,
//                    "amount":"\(expenseAmountField.text!)",
//                    "image":imageName,
//                    "date":dateTime.text!,
//                    "type":switchTransaction.isOn
//                ])
//            }
        }
        
        
        self.dismiss(animated: true)
    }
    func getDocumentDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    
}

extension InputExpenseViewController{
    

    
    
    @objc func btnSave(){
        
        expenseAmount = Int(expenseAmountField.text!)!
        let dict = ([
            "expenseAmount":expenseAmount
        ])
        guard let completion else {return}
        completion(dict)
        let dic:([String:Any]) = ([
            "title":expenseTitleField.text!,
            "amount":"\(expenseAmountField.text!)",
            "image":imageHandle ?? "hehe",
            "date":dateTime.text!,
            "type":switchTransaction.isOn
        ])
        

        if isUpdate{
            DatabaseHelper.shared.editData(object: dic, i: index)
            isUpdate = false
        }else{
            DatabaseHelper.shared.save(object: dic)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
