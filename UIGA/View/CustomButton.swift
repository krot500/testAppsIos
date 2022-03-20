//
//  CustomButton.swift
//  UIGA
//
//  Created by Nikita Sibirtsev on 17/03/2022.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.gray
        tintColor = UIColor.green
        titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 25)
    }
    
}
