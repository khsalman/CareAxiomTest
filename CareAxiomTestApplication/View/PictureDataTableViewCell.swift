//
//  PictureDataTableViewCell.swift
//  CareAxiomTestApplication
//
//  Created by Khawaja Salman Nadeem on 13/09/2021.
//

import UIKit

class PictureDataTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailUrlLabel: UILabel!
    
    // MARK: - PreDefined initialser Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
