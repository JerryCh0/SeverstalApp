//
//  CabinetViewController.swift
//  Severstal
//
//  Created by Дмитрий Ткаченко on 04/03/2018.
//  Copyright © 2018 bsws. All rights reserved.
//

import UIKit
import JTAppleCalendar

let selectedDateNotification = Notification.Name("selectedDate")

class CabinetViewController: UITableViewController {
    
    let formatter = DateFormatter()
    @IBOutlet weak var calendar: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    let tasksGuy = TasksGuy()
    @IBOutlet weak var tasksTable: UITableView!
    
    
    
    let monthColor = UIColor.white
    let selectedMonthColor = UIColor.darkGray
    let outsideMonthColor = UIColor.lightGray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendar.ibCalendarDelegate = self
        self.calendar.ibCalendarDataSource = self
        
        self.setupCalendarView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTasks(_:)), name: selectedDateNotification, object: nil)
        
        
        self.tasksTable.dataSource = self.tasksGuy
        self.tasksTable.delegate = self.tasksGuy
        self.tasksTable.setEditing(true, animated: true)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func updateTasks(_ notification: NSNotification) {
        
        if let day = notification.userInfo?["day"] as? Int {
            self.tasksGuy.daytag = day
        }
        
        self.tasksTable.reloadData()
    }
    
    func setupCalendarView() {
        self.calendar.minimumLineSpacing = 0
        self.calendar.minimumInteritemSpacing = 0
        
        self.calendar.visibleDates { (visibleDates) in
            let date = visibleDates.monthDates.first!.date
            
            self.formatter.dateFormat = "yyyy"
            self.year.text = self.formatter.string(from: date)
            
            self.formatter.dateFormat = "MMMM"
            self.month.text = self.formatter.string(from: date)
        }
        
    }
    
    func handleCellSelected(cell : JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CalendarCell else { return }
        if cellState.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    func handleCellTextColor(cell : JTAppleCell?, cellState: CellState, date: Date) {
        guard let validCell = cell as? CalendarCell else { return }
        
        if cellState.isSelected {
            validCell.dateLabel.textColor = selectedMonthColor
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = monthColor
            } else {
                validCell.dateLabel.textColor = outsideMonthColor
            }
        }
        
        self.formatter.dateFormat = "yyyy MM dd"
        
        if date == formatter.date(from: "2018 01 11") {
            validCell.dateLabel.textColor = UIColor.red
        }
        
        if date == formatter.date(from: "2018 01 19") {
            validCell.dateLabel.textColor = UIColor.red
        }
        
        if date == formatter.date(from: "2018 02 14") {
            validCell.dateLabel.textColor = UIColor.red
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 3
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        if section == 0 {
//            return tasks[daytag].count
//        }
//        return 1
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CabinetViewController: JTAppleCalendarViewDataSource {
    
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")
        let endDate = formatter.date(from: "2018 12 31")
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
    
}

extension CabinetViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        return
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        cell.dateLabel.text = cellState.text
        
        self.handleCellSelected(cell: cell, cellState: cellState)
        self.handleCellTextColor(cell: cell, cellState: cellState, date: date)
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        self.handleCellSelected(cell: cell, cellState: cellState)
        self.handleCellTextColor(cell: cell, cellState: cellState, date: date)
        
        self.formatter.dateFormat = "yyyy MM dd"
        
        var info = ["day" : 0]
        
        if date == formatter.date(from: "2018 01 11") {
            info["day"] = 0
            NotificationCenter.default.post(name: selectedDateNotification, object: nil, userInfo: info)
        } else {
            if date == formatter.date(from: "2018 01 19") {
                info["day"] = 1
                NotificationCenter.default.post(name: selectedDateNotification, object: nil, userInfo: info)
            } else {
                if date == formatter.date(from: "2018 02 14") {
                    info["day"] = 2
                    NotificationCenter.default.post(name: selectedDateNotification, object: nil, userInfo: info)
                } else {
                    info["day"] = 3
                    NotificationCenter.default.post(name: selectedDateNotification, object: nil, userInfo: info)
                }
            }
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        self.handleCellSelected(cell: cell, cellState: cellState)
        self.handleCellTextColor(cell: cell, cellState: cellState, date: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        formatter.dateFormat = "yyyy"
        year.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        month.text = formatter.string(from: date)
    }
}

class TasksGuy : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let tasks = [["Составить отчет о состоянии эксгаустера 7"], ["Осмотреть эксгаустер 3", "Осмотреть эксгаустер 4", "Осмотреть эксгаустер 5"], ["Починить эксгаустер 6", "Осмотреть эксгаустер 4"], []]
    var daytag = 3
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks[daytag].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        cell.taskLabel.text = self.tasks[daytag][indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle(rawValue: 3)!
    }
    
    
}
