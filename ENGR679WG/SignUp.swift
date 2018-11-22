//
//  SignUp.swift
//  ENGR679WG
//
//  Created by Abdulaziz Alharbi on 10/12/18.
//  Copyright © 2018 Abdulaziz Alharbi. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignUp: UIViewController {

   
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupButton(_ sender: Any) {
        
        SVProgressHUD.show()
        
        //Set up a new user on our Firebase database
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
                SVProgressHUD.dismiss()
                
               let alertVC = UIAlertController(title: "Error", message: "The Email you entered already exist", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                    alertVC.dismiss(animated: true, completion: nil)
                })
                alertVC.addAction(okAction)
                self.present(alertVC, animated: true, completion: nil)
                
            } else {
                print("Registration Successful!")
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "toMainPage", sender: self)
            }
        }
        
    }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


