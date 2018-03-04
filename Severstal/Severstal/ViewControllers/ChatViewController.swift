//
//  ChatViewController.swift
//  Severstal
//
//  Created by Дмитрий Ткаченко on 04/03/2018.
//  Copyright © 2018 bsws. All rights reserved.
//

import UIKit

let sendMsgNotification = Notification.Name("sendMsgNotification")

class ChatViewController: UIViewController {

    @IBOutlet weak var msgField: UITextField!
    @IBOutlet weak var msgTable: UITableView!
    
    var sections = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.msgTable.delegate = self
        self.msgTable.dataSource = self
        
        self.msgField.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMsg(_ sender: UIButton) {
        self.sections = 2
        self.msgField.text = ""
        self.msgTable.reloadData()
        NotificationCenter.default.post(name: sendMsgNotification, object: nil)
    }

}

extension ChatViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerCell
        return cell
        
    }
    
    
}

extension ChatViewController: UITableViewDelegate {
    
}
