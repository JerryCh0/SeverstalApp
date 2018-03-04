//
//  RepairViewController.swift
//  Severstal
//
//  Created by Дмитрий Ткаченко on 04/03/2018.
//  Copyright © 2018 bsws. All rights reserved.
//

import UIKit

class RepairViewController: UIViewController {
    
    let data = [[("8", 33), ("9", 31), ("6", 22), ("5", 19), ("7", 12), ("4", 7)],
                [("8", 42), ("9", 37), ("5", 23), ("7", 21), ("6", 19), ("4", 12)],
                [("9", 37), ("8", 31), ("5", 25), ("6", 22), ("4", 13), ("7", 9)],
                [("6", 51), ("8", 28), ("9", 19), ("5", 17), ("7", 12), ("4", 12)],
                
                [("9", 12), ("8", 9), ("5", 7), ("7", 6), ("6", 5), ("4", 5)],
                [("8", 14), ("9", 11), ("7", 9), ("5", 7), ("6", 7), ("4", 5)],
                [("9", 21), ("8", 18), ("5", 17), ("7", 17), ("4", 12), ("6", 10)],
                [("9", 33), ("8", 27), ("7", 25), ("5", 24), ("6", 19), ("4", 19)]]
    
    let components = ["24 часа", "72 часа", "2 недели", "30 дней"]
    
    var segment = 0
    var row = 1

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var exgTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.dataSource = self
        self.picker.delegate = self
        
        self.exgTable.dataSource = self
        self.exgTable.delegate = self
        
        self.picker.selectRow(self.row, inComponent: 0, animated: true)

        // Do any additional setup after loading the view.
    }

    @IBAction func changedSegment(_ sender: UISegmentedControl) {
        self.segment = sender.selectedSegmentIndex
        self.exgTable.reloadData()
        self.exgTable.selectRow(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.top)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension RepairViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[4 * self.segment + self.row].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExgCell", for: indexPath) as! ExgCell
        
        let num = data[4 * self.segment + self.row][indexPath.item].0
        let prob = "\(data[4 * self.segment + self.row][indexPath.item].1)"
        
        cell.exgLabel.text = "Эксгаустер \(num)"
        cell.probLabel.text = "Вероятность \(prob)%."
        
        return cell
    }
    
    
}

extension RepairViewController : UITableViewDelegate {
    
}

extension RepairViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.components.count
    }
    
    
}

extension RepairViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.components[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.row = row
        self.exgTable.reloadData()
        self.exgTable.selectRow(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.top)
    }
}
