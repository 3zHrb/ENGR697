//
//  BLEsettings.swift
//  ENGR679WG
//
//  Created by Abdulaziz Alharbi on 11/20/18.
//  Copyright © 2018 Abdulaziz Alharbi. All rights reserved.
//

import UIKit

class BLEsettings: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    
    
    @IBOutlet weak var UITableView0: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITableView0.delegate = self
        UITableView0.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let CellVar = tableView.dequeueReusableCell(withIdentifier: "TheCell0", for: indexPath) as? CellTableViewCell{
            
            CellVar.bluetoothName.text = "zyz"
            
            return CellVar
        }
        
        return CellTableViewCell()
        
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
