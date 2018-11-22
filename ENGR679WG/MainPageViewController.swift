//
//  MainPageViewController.swift
//  ENGR679WG
//
//  Created by Abdulaziz Alharbi on 11/21/18.
//  Copyright © 2018 Abdulaziz Alharbi. All rights reserved.
//

import UIKit
import Firebase

class MainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
       
        do {
       try Auth.auth().signOut()
navigationController?.popToRootViewController(animated: true)
        }catch{
            
            print("there is a problem with signOut")
            
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
