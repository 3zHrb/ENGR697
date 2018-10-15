//
//  Calender.swift
//  ENGR679WG
//
//  Created by Abdulaziz Alharbi on 10/12/18.
//  Copyright © 2018 Abdulaziz Alharbi. All rights reserved.
//

import UIKit
import GCCalendar

class Calender: UIViewController, GCCalendarViewDelegate {
    
    
    
    func calendarView(_ calendarView: GCCalendarView, didSelectDate date: Date, inCalendar calendar: Calendar) {
        
        calendarView.isHidden = false
        calendarView.displayMode = .month
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let calendarView = GCCalendarView()
        calendarView.delegate = self
        calendarView.isHidden = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
