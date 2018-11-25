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
    
    
   
    

    

    var CBManager : CBCentralManager?
    var names:[String] = []
    var BLEDevices: [CBPeripheral] = []
    var myPeripheral : CBPeripheral?
    
    var uuid: Any?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        
        CBManager?.scanForPeripherals(withServices: [CBUUID.init(string: "DFB0")], options: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let CellVar = tableView.dequeueReusableCell(withIdentifier: "TheCell0", for: indexPath) as? CellTableViewCell{
            // Array(Set(names))
            myPeripheral = BLEDevices[indexPath.row]
            CellVar.bluetoothName.text = myPeripheral?.name
            
            //Cellvar.uuidLable.texy =
            
            return CellVar
        }
        
        return CellTableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let choosen = BLEDevices[indexPath.row]
        CBManager?.connect(choosen, options: nil)
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        
        let alertVC = UIAlertController(title: "Connected!", message: "The device you selected is now connected", preferredStyle: .alert)
        
        let alertAc = UIAlertAction(title: "ok", style: .default) { (UIAlertAction) in
            
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
            
        }
        
        alertVC.addAction(alertAc)
        
        present(alertVC, animated: true, completion: nil)
        
        
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if central.state == .poweredOn {
            
            central.scanForPeripherals(withServices: [CBUUID.init(string: "DFB0")], options: nil)
            
            
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
        
        myPeripheral = peripheral
        BLEDevices.append(peripheral)
        
        print("*********************")
        if let namePer = peripheral.name {
        print("periphiral name: ", namePer)
            
       names.append(namePer)
           
             UITableView0.reloadData()
            //central.stopScan()
        }
       // print("advertisement Data: ", //advertisementData["kCBAdvDataServiceUUIDs"])
       //uuid = advertisementData["kCBAdvDataServiceUUIDs"]
        
        print("RSSI", RSSI)
        print("UUID", peripheral.identifier.uuidString)
        print("*********************")
    
       
        
    }
    
   
    
    @IBAction func refreshButton(_ sender: Any) {
        
        names = []
       
        CBManager?.scanForPeripherals(withServices: [CBUUID.init(string: "DFB0")], options: nil)
        //CBManager?.stopScan()
        UITableView0.reloadData()
    }
    
    
   /* func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        let alertVC = UIAlertController(title: "Connected", message: "The Device is now connected! ", preferredStyle: .alert)
        
        let theAction = UIAlertAction(title: nil, style: .default) { (UIAlertAction) in
            alertVC.dismiss(animated: true, completion: nil)
            
        }
        alertVC.addAction(theAction)
        
        present(alertVC, animated: true, completion: nil)
        
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
