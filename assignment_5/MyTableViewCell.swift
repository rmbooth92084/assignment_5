//
//  MyTableViewCell.swift
//  assignment_5
//
//  Created by user227341 on 11/11/22.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
