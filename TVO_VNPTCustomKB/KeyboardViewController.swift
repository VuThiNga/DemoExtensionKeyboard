//
//  KeyboardViewController.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 4/27/21.
//

import UIKit
import Foundation
import MBProgressHUD

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectedUntilityLb: UILabel!
    var keyboardView: UIView!
    var vm = KeyboardVM()
    
    private let untilityList = [
        UntilityModels(idUntility: "1", nameUntility: "Danh bạ", imageUntility: UIImage(named: "phone_book")),
        UntilityModels(idUntility: "2", nameUntility: "Hạn mức", imageUntility: UIImage(named: "limited_time")),
        UntilityModels(idUntility: "3", nameUntility: "Thông tin tài khoản", imageUntility: UIImage(named: "acc_information")),
        UntilityModels(idUntility: "4", nameUntility: "Chuyển tiền", imageUntility: UIImage(named: "money_growth"))
    ]

    var cellUntility = "ItemKeyboardCell"

    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
        keyboardView.frame.size = view.frame.size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
        // Perform custom UI setup here
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let heightConstraint = NSLayoutConstraint(item: view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 220)
        view.addConstraint(heightConstraint)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: cellUntility, bundle: nil), forCellWithReuseIdentifier: cellUntility)
    }
    
    func loadInterface(){
        let keyboardNib = UINib(nibName: "Keyboard", bundle: nil)
        keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)[0] as? UIView
        keyboardView.sizeToFit()
        view.addSubview(keyboardView)
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.

        self.setColorScheme(getColorScheme())
    }
    
    func getColorScheme() -> KeyboardColorScheme{
        if textDocumentProxy.keyboardAppearance == .dark {
          return .dark
        } else {
          return .light
        }
    }

}

extension KeyboardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return untilityList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = untilityList[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellUntility, for: indexPath) as? ItemKeyboardCell else {
            return UICollectionViewCell()
        }

        cell.configCell(item, colorScheme: getColorScheme())
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 120)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        toggleSelectColor(collectionView: collectionView, isShow: true, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        toggleSelectColor(collectionView: collectionView, isShow: false, indexPath: indexPath)
    }
    
    private func toggleSelectColor(collectionView: UICollectionView, isShow: Bool, indexPath: IndexPath) {
        if isShow {
            self.selectedUntilityLb.text = (collectionView.cellForItem(at: indexPath) as? ItemKeyboardCell)?.textLb.text
            (collectionView.cellForItem(at: indexPath) as? ItemKeyboardCell)?.textLb.textColor = KeyboardColors(colorScheme: getColorScheme()).selectedTextIconColor
            // Fallback on earlier versions
            (collectionView.cellForItem(at: indexPath) as? ItemKeyboardCell)?.borderView.backgroundColor = KeyboardColors(colorScheme: getColorScheme()).selectedBackgroundIconView
            if indexPath.row == 0 {
                getContacts(collectionView: collectionView, indexPath: indexPath)
            }
            
        } else {
            // Fallback on earlier versions
            (collectionView.cellForItem(at: indexPath) as? ItemKeyboardCell)?.textLb.textColor = KeyboardColors(colorScheme: getColorScheme()).unselectedTextIconColor
            (collectionView.cellForItem(at: indexPath) as? ItemKeyboardCell)?.borderView.backgroundColor = KeyboardColors(colorScheme: getColorScheme()).unselectedBackgroundIconView
        }
    }
    
    private func getContacts(collectionView: UICollectionView, indexPath: IndexPath) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        vm.loadJson(filename: "contacts", success: { [weak self] count in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self?.view ?? UIView(), animated: true)
                self?.selectedUntilityLb.text = "\((collectionView.cellForItem(at: indexPath) as? ItemKeyboardCell)?.textLb.text ?? "") (\(count))"
            }
            
        }, fail: {
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.selectedUntilityLb.text = (collectionView.cellForItem(at: indexPath) as? ItemKeyboardCell)?.textLb.text
            }
        })
    }
}

extension KeyboardViewController {
    func setColorScheme(_ colorScheme: KeyboardColorScheme) {
        let colorScheme = KeyboardColors(colorScheme: colorScheme)
        selectedUntilityLb.textColor = colorScheme.previewTextColor
        view.backgroundColor = colorScheme.backgroundColor
    }
}



