//
//  BLEsettings.swift
//  ENGR679WG
//
//  Created by Abdulaziz Alharbi on 11/20/18.
//  Copyright © 2018 Abdulaziz Alharbi. All rights reserved.
//

import UIKit
import CoreBluetooth

class BLEsettings: UIViewController, UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate {
    
    
   
    

    

    var CBManager : CBCentralManager!
    var names:[String] = []
    
    @IBOutlet weak var UITableView0: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITableView0.delegate = self
        UITableView0.dataSource = self
        
        CBManager = CBCentralManager(delegate: self, queue: nil)
        
        //CBManager.scanForPeripherals(withServices: nil, options: nil)
         UITableView0.reloadData()

        // Do any additional setup after loading the view.
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let CellVar = tableView.dequeueReusableCell(withIdentifier: "TheCell0", for: indexPath) as? CellTableViewCell{
            
            CellVar.bluetoothName.text = names[indexPath.row]
            
            return CellVar
        }
        
        return CellTableViewCell()
        
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if central.state == .poweredOn {
            
            central.scanForPeripherals(withServices: nil, options: nil)
            
        }else{
            
       let alertVC = UIAlertController(title: "Error", message: "something went wrong while scanning for devices", preferredStyle: .alert)
            
           let alertOK = UIAlertAction(title: "ok", style: .default) { (UIAlertAction) in
                alertVC.dismiss(animated: true, completion: nil)
            }
            
            alertVC.addAction(alertOK)
            
            present(alertVC, animated: true, completion: nil)
            
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        
        if let namePer = peripheral.name {
        print("periphiral name: ", namePer)
            
       names.append(namePer)
             UITableView0.reloadData()
            central.stopScan()
        }
        print("advertisement Data: ", advertisementData)
        print("RSSI", RSSI)
        print("UUID", peripheral.identifier.uuidString)
        
    
       
        
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
