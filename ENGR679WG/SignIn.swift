//
//  SignIn.swift
//  ENGR679WG
//
//  Created by Abdulaziz Alharbi on 10/12/18.
//  Copyright © 2018 Abdulaziz Alharbi. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignIn: UIViewController {

    @IBOutlet var emailTextField: UITextField!// is set to be strong !!
    @IBOutlet var passwordTextField: UITextField! // is set to be strong !!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButton(_ sender: Any) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("Log in successful!")
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "toCalender", sender: self)
                
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

}
