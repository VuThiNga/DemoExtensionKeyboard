//
//  KeyboardColorScheme.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 4/28/21.
//

import UIKit

enum KeyboardColorScheme {
    case dark
    case light
}

struct KeyboardColors {
    let previewTextColor: UIColor
    let selectedBackgroundIconView: UIColor
    let unselectedBackgroundIconView: UIColor
    let selectedTextIconColor: UIColor
    let unselectedTextIconColor: UIColor
    let backgroundColor: UIColor
    
    init(colorScheme: KeyboardColorScheme) {
        switch colorScheme {
        case .light:
            previewTextColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            unselectedBackgroundIconView = UIColor.clear
            selectedBackgroundIconView = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            selectedTextIconColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            unselectedTextIconColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            backgroundColor = #colorLiteral(red: 0.5373843773, green: 0.8392156959, blue: 0.9764705896, alpha: 0.2881795805)
        case .dark:
            previewTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            selectedBackgroundIconView = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            selectedTextIconColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            unselectedTextIconColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            unselectedBackgroundIconView = UIColor.clear
            backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
}
