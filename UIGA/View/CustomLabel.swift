//
//  CustomLabel.swift
//  UIGA
//
//  Created by Nikita Sibirtsev on 19/03/2022.
//

import UIKit

class CustomLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = UIColor.white
        font = UIFont(name: "AvenirNext-Regular", size: 25)
        
    }

}
