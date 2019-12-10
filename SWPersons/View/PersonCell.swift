//
//  PersonCell.swift
//  SWPersons
//
//  Created by Никита Главацкий on 05.12.2019.
//  Copyright © 2019 StreetPeople. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet weak var personNameField: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
