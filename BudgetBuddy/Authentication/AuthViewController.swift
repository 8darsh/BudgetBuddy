//
//  AuthViewController.swift
//  BudgetBuddy
//
//  Created by Adarsh Singh on 25/09/23.
//

import UIKit
import GoogleSignIn
import LocalAuthentication
class AuthViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    //    var emailAddress = String()
    //    var fullName = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var context = LAContext()
        var biometry = context.biometryType
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none) {
            let reason = "Identify yourself!"
            
            // Face Id
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as!
                        TabBarViewController
                        self?.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
            //Touch Id
            //            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
            //                DispatchQueue.main.async {
            //                    if success {
            //
            //                    } else {
            //                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
            //                        ac.addAction(UIAlertAction(title: "OK", style: .default))
            //                        self.present(ac, animated: true)
            //                    }
            //                }
            //            }
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
        
        
    }
}
    
//    @IBAction func signIn(_ sender: UIButton) {
//        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
//          guard error == nil else { return }
//            guard let signInResult = signInResult else { return }
//
////            signInResult.user.refreshTokensIfNeeded { user, error in
////                guard error == nil else { return }
////                guard let user = user else { return }
////
////                let idToken = user.idToken
////                
////            }
//            let user = signInResult.user
//            
//            print(user)
//            self.emailAddress = user.profile?.email ?? "Sample"
//
//            self.fullName = user.profile?.name ?? "Name"
//
//
//            
//            DispatchQueue.main.async {
//                let ac = UIAlertController(title: "Income", message: "Add Your Montlhy Income", preferredStyle: .alert)
//                ac.addTextField()
//                print(ac.textFields?[0].text)
//                ac.addAction(UIAlertAction(title: "Done", style: .default,handler: { [weak ac]  _ in
//                    let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
//                    vc.incomeSetter = Int(ac?.textFields?[0].text ?? "40000")!
//                    
//                    
//                }))
//                self.present(ac,animated: true)
//            }

        
        
    
    


