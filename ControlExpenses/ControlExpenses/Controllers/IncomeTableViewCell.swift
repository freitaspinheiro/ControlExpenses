//
//  IncomeTableViewCell.swift
//  ControlExpenses
//
//  Created by COTEMIG on 23/03/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import UIKit

class IncomeTableViewCell: UITableViewCell {

    @IBOutlet weak var lbDescript: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbValue: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
}
