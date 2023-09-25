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
    

    
    @IBAction func signOutbtn(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signOut()
       
        self.navigationController?.popViewController(animated: true)
    }
    



}
