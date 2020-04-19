//
//  SiteCell.swift
//  w8Table
//
//  Created by Xcode User on 2020-03-06.
//  Copyright © 2020 Quynh Dinh. All rights reserved.
//

import UIKit

class SiteCell: UITableViewCell {
    
    // Declare layout of the cell
    let primaryLabel = UILabel()
    let secondaryLabel = UILabel()
    let teamImageView = UIImageView()
    
    // Constructor -> Initiate the cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        // Set layout
        primaryLabel.textAlignment = .left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 30)
        primaryLabel.backgroundColor = .clear
        primaryLabel.textColor = .black
        
        secondaryLabel.textAlignment = .left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 16)
        secondaryLabel.backgroundColor = .clear
        secondaryLabel.textColor = .blue
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add control elements to table cell
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
        contentView.addSubview(teamImageView)
    }
    
    // Set positions for control elements
    override func layoutSubviews() {
        primaryLabel.frame = CGRect(x: 100, y: 5, width: 460, height: 30)
        secondaryLabel.frame = CGRect(x:100, y:40, width: 460, height: 30)
        teamImageView.frame = CGRect(x: 5, y: 5, width: 45, height: 45)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // VIew did load type of UITableView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        // This function is fired when the cell is selected
    }

}
