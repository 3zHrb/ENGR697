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
    
    
    var manager : CBCentralManager? = nil//changed
    var names:[String] = []
    var peripherals: [CBPeripheral] = []//changed
    var myPeripheral : CBPeripheral?
    var parentView:MainPageViewController? = nil//added
    var choosen : CBPeripheral? = nil
    
    var uuid: Any?
    
    @IBOutlet weak var disconnectButton: UIBarButtonItem!
    
    
    @IBAction func disconnectButton(_ sender: Any) {
        
        
        if let hasChoosen = choosen{
        manager?.cancelPeripheralConnection(hasChoosen)
            
            let alertVC = UIAlertController(title: "Disconnected!", message: "The device you selected is now Disconnected", preferredStyle: .alert)
            
            let alertAc = UIAlertAction(title: "ok", style: .default) { (UIAlertAction) in
                
               /* if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }*/
                
            }
            
            alertVC.addAction(alertAc)
            
            present(alertVC, animated: true, completion: nil)
            disconnectButton.tintColor = UIColor.gray
            disconnectButton.isEnabled = false
        }
    }
    
    

  
    
    @IBOutlet weak var UITableView0: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UITableView0.delegate = self
        UITableView0.dataSource = self
        
        manager = CBCentralManager(delegate: self, queue: nil)
        
        //CBManager.scanForPeripherals(withServices: nil, options: nil)
        
        
        if (choosen == nil){
            
            disconnectButton.tintColor = UIColor.gray
            disconnectButton.isEnabled = false
            
            
        }
         UITableView0.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //manager?.scanForPeripherals(withServices: [CBUUID.init(string: "DFB0")], options: nil)
        
       
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return names.count
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let CellVar = tableView.dequeueReusableCell(withIdentifier: "TheCell0", for: indexPath) as? CellTableViewCell{
            // Array(Set(names))
           myPeripheral = peripherals[indexPath.row]
            CellVar.bluetoothName.text = myPeripheral?.name
            
            //Cellvar.uuidLable.texy =
            
            return CellVar
        }
        
        return CellTableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosen = peripherals[indexPath.row]
        
        if let connected = choosen{
        manager?.connect(connected, options: nil)
            disconnectButton.tintColor = UIColor.red
            disconnectButton.isEnabled = true
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        parentView?.mainPeripheral = peripheral
        peripheral.delegate = parentView
        peripheral.discoverServices(nil)
        
        //set the manager's delegate view to parent so it can call relevant disconnect methods
        manager?.delegate = parentView
       // parentView?.customiseNavigationBar()
        
       /* if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }*/
        
        print("Connected to " +  peripheral.name!)
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
        
        
        if(!peripherals.contains(peripheral)) {
            peripherals.append(peripheral)
        }
        
        
        
       //myPeripheral = peripheral
       //peripherals.append(peripheral)
        
        
        
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
    
       
        
        central.stopScan()
        self.UITableView0.reloadData()
    }
    
   
    
    @IBAction func refreshButton(_ sender: Any) {
        
        names = []
       
        manager?.scanForPeripherals(withServices: [CBUUID.init(string: "DFB0")], options: nil)
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
    
    
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print(error!)
    }
    
    //

}
