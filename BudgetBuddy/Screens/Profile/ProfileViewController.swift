//
//  ProfileViewController.swift
//  BudgetBud
//
//  Created by Adarsh Singh on 23/09/23.
//

import UIKit
import GoogleSignIn
class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
    }
    

    
//    @IBAction func signOutbtn(_ sender: UIButton) {
//        GIDSignIn.sharedInstance.signOut()
//       
//        self.navigationController?.popViewController(animated: true)
//    }
//    



}
extension ProfileViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "Personal Information"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PersonalInfoViewController") as! PersonalInfoViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
