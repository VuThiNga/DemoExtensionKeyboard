//
//  UntilityKeyboardCell.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 5/13/21.
//

import UIKit

class UntilityKeyboardCell: UICollectionViewCell {
    
    let borderView: UIView = {
        let boderview = UIView()
        boderview.backgroundColor = .clear
        boderview.translatesAutoresizingMaskIntoConstraints = false
        boderview.clipsToBounds = true
        boderview.layer.cornerRadius = 12
        return boderview
    }()
    
    let imagView: UIImageView = {
        let imgV = UIImageView()
        imgV.translatesAutoresizingMaskIntoConstraints = false
        imgV.contentMode = .scaleAspectFit
        imgV.clipsToBounds = true
        return imgV
    }()
    
    let textLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configCell(_ data: UntilityModels, colorScheme: KeyboardColorScheme) {
        textLb.text = data.nameUntility
        let colorScheme = KeyboardColors(colorScheme: colorScheme)
        textLb.textColor = colorScheme.unselectedTextIconColor
        imagView.image = data.imageUntility
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.borderView)
        NSLayoutConstraint.activate([
            self.borderView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            self.borderView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.borderView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.borderView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10)
        ])
        self.contentView.addSubview(self.imagView)
        NSLayoutConstraint.activate([
            self.imagView.leftAnchor.constraint(equalTo: self.borderView.leftAnchor, constant: 5),
            self.imagView.topAnchor.constraint(equalTo: self.borderView.topAnchor, constant: 10),
            self.imagView.rightAnchor.constraint(equalTo: self.borderView.rightAnchor, constant: -5),
            self.imagView.heightAnchor.constraint(equalToConstant: 35.0)
        ])
        self.contentView.addSubview(self.textLb)
        NSLayoutConstraint.activate([
            self.textLb.leftAnchor.constraint(equalTo: self.borderView.leftAnchor, constant: 5),
            self.textLb.bottomAnchor.constraint(equalTo: self.borderView.bottomAnchor, constant: -10),
            self.textLb.topAnchor.constraint(greaterThanOrEqualTo: self.imagView.bottomAnchor, constant: 5),
            self.textLb.rightAnchor.constraint(equalTo: self.borderView.rightAnchor, constant: -5),
            self.textLb.centerXAnchor.constraint(equalTo: self.borderView.centerXAnchor)
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
