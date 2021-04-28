//
//  ItemKeyboardCell.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 4/27/21.
//

import UIKit

class ItemKeyboardCell: UICollectionViewCell {

    @IBOutlet weak var textLb: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var imagView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        borderView.layer.cornerRadius = 12
    }

    func configCell(_ data: UntilityModels, colorScheme: KeyboardColorScheme) {
        textLb.text = data.nameUntility
        let colorScheme = KeyboardColors(colorScheme: colorScheme)
        textLb.textColor = colorScheme.unselectedTextIconColor
        imagView.image = data.imageUntility
    }
}
