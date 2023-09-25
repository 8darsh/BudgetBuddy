//
//  AuthViewController.swift
//  BudgetBuddy
//
//  Created by Adarsh Singh on 25/09/23.
//

import UIKit
import GoogleSignIn
class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
          guard error == nil else { return }
            guard let signInResult = signInResult else { return }

            signInResult.user.refreshTokensIfNeeded { user, error in
                guard error == nil else { return }
                guard let user = user else { return }

                let idToken = user.idToken
                
            }

            let vc = self.storyboard?.instantiateViewController(identifier: "TabBarViewController") as!
            TabBarViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    

}
