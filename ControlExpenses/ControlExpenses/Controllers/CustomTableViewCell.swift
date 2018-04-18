//
//  CustomTableViewCell.swift
//  ControlExpenses
//
//  Created by COTEMIG on 08/03/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lbDescript: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbValue: UILabel!
    @IBOutlet weak var lbPaid: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
}
