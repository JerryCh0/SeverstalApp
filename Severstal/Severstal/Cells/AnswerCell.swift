//
//  AnswerCell.swift
//  Severstal
//
//  Created by Дмитрий Ткаченко on 04/03/2018.
//  Copyright © 2018 bsws. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {

    @IBOutlet weak var answerLabel: SmartLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
