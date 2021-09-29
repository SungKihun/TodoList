//
//  TodoCell.swift
//  TodoList
//
//  Created by 성기훈 on 2021/09/30.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet var topTitleLabel: UILabel!
    @IBOutlet var prioirtyView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
