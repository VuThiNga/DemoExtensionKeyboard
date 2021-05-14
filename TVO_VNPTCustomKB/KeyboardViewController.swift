//
//  KeyboardViewController.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 4/27/21.
//

import UIKit
import Foundation
import MBProgressHUD
import SwiftyGif
import MobileCoreServices

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectedUntilityLb: UILabel!
    @IBOutlet weak var descriptionLB: UILabel!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var displayNumberLb: UILabel!
    var keyboardView: UIView!
    var vm = KeyboardVM()
    
//    var collectionView: UICollectionView!
//    var imageView: UIImageView!
//    var descriptionLB: UILabel!
//    var selectedUntilityLb: UILabel!
//
    var presentedItemURL: URL?
    var presentedItemOperationQueue: OperationQueue = OperationQueue.main
    
    private var untilityList =  [UntilityModels]()
    var cellUntility = "ItemKeyboardCell"

    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
        keyboardView.frame.size = view.frame.size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
        
        let file = "keyboard.txt"
        let dir = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.ngavt.tvo.KeyboardCustomTVO")!
        presentedItemURL = dir.appendingPathComponent(file)
        untilityList = vm.initUntilityList()
        self.tfPhone.isUserInteractionEnabled = false
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        writeToFile(urlStr: "https://media.giphy.com/media/3og0IUEEbY9wRwrBL2/giphy.gif")
    }
    
    @objc func displayLbTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        showPopupEnterNumber()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let heightConstraint = NSLayoutConstraint(item: view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 300)
        view.addConstraint(heightConstraint)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
    }
    
    func loadInterface(){
        let keyboardNib = UINib(nibName: "Keyboard", bundle: nil)
        keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)[0] as? UIView
        keyboardView.sizeToFit()
        view.addSubview(keyboardView)
        let tapGesLb = UITapGestureRecognizer(target: self, action: #selector(displayLbTapped(tapGestureRecognizer:)))
        displayNumberLb.isUserInteractionEnabled = true
        displayNumberLb.addGestureRecognizer(tapGesLb)
//        self.nextKeyboardButton = UIButton()
//
//        self.nextKeyboardButton.setBackgroundImage(UIImage(named: "ic_globe"), for: .normal)
//        // Perform custom UI setup here
//        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
//        self.view.addSubview(self.nextKeyboardButton)
        
        
//        NSLayoutConstraint.activate([
//            self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
//            self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
//            self.nextKeyboardButton.heightAnchor.constraint(equalToConstant: 24.0),
//            self.nextKeyboardButton.widthAnchor.constraint(equalTo: self.nextKeyboardButton.heightAnchor)
//        ])
//
//        imageView = UIImageView()
//        self.imageView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(self.imageView)
//        NSLayoutConstraint.activate([
//            self.imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
//            self.imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
//            self.imageView.heightAnchor.constraint(equalToConstant: 50.0),
//            self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor)
//        ])
//
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        //collectionView.setCollectionViewLayout(layout, animated: true)
//        collectionView.register(UntilityKeyboardCell.self, forCellWithReuseIdentifier: "Cell")
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.backgroundColor = .clear
//        self.view.addSubview(self.collectionView)
//        NSLayoutConstraint.activate([
//            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
//            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
//            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
//            self.collectionView.heightAnchor.constraint(equalToConstant: 120.0),
//        ])
//        
//        selectedUntilityLb = UILabel()
//        selectedUntilityLb.textAlignment = .center
//        selectedUntilityLb.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//        selectedUntilityLb.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(selectedUntilityLb)
//        NSLayoutConstraint.activate([
//            self.selectedUntilityLb.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
//            self.selectedUntilityLb.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 20),
//            self.selectedUntilityLb.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//        ])
//        
//        descriptionLB = UILabel()
//        descriptionLB.textAlignment = .left
//        descriptionLB.font = UIFont.systemFont(ofSize: 14)
//        descriptionLB.text = "Chọn Hạn mức để xem thông tin API VNPT"
//        descriptionLB.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(descriptionLB)
//        NSLayoutConstraint.activate([
//            self.descriptionLB.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
//            self.descriptionLB.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 20),
//            self.descriptionLB.topAnchor.constraint(equalTo: self.selectedUntilityLb.bottomAnchor, constant: 10),
//            self.descriptionLB.bottomAnchor.constraint(lessThanOrEqualTo: self.nextKeyboardButton.topAnchor, constant: -10)
//        ])
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UntilityKeyboardCell.self, forCellWithReuseIdentifier: "Cell")
        //self.collectionView.register(UINib(nibName: cellUntility, bundle: nil), forCellWithReuseIdentifier: cellUntility)
        let url = URL(string: "https://media.giphy.com/media/3og0IUEEbY9wRwrBL2/giphy.gif")
        let loader = UIActivityIndicatorView(style: .white)
        if let url = url {
        imageView.setGifFromURL(url, customLoader: loader)
        }
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? UntilityKeyboardCell else {
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
            self.selectedUntilityLb.text = (collectionView.cellForItem(at: indexPath) as? UntilityKeyboardCell)?.textLb.text
            (collectionView.cellForItem(at: indexPath) as? UntilityKeyboardCell)?.textLb.textColor = KeyboardColors(colorScheme: getColorScheme()).selectedTextIconColor
            // Fallback on earlier versions
            (collectionView.cellForItem(at: indexPath) as? UntilityKeyboardCell)?.borderView.backgroundColor = KeyboardColors(colorScheme: getColorScheme()).selectedBackgroundIconView
            if indexPath.row == 0 {
                self.descriptionLB.text = "Chọn Hạn mức để xem thông tin API VNPT"
                getContacts(collectionView: collectionView, indexPath: indexPath)
            }else if indexPath.row == 1 {
                callVNPTAPI()
            }else if indexPath.row == 2 {
                self.textDocumentProxy.insertText("Thông tin tài khoản")
                self.descriptionLB.text = "Chọn Hạn mức để xem thông tin API VNPT"
            }else {
                //do something
                self.descriptionLB.text = "Chọn Hạn mức để xem thông tin API VNPT"
                
                let pb = UIPasteboard.general
                
                let image: UIImage = untilityList[indexPath.row].imageUntility ?? UIImage()
                if let data = image.pngData() {
                    pb.setData(data,forPasteboardType: kUTTypePNG as String)
                    self.showToast(message: "Copy image successful", font: UIFont.systemFont(ofSize: 12))
                }
                
            }
            
        } else {
            // Fallback on earlier versions
            (collectionView.cellForItem(at: indexPath) as? UntilityKeyboardCell)?.textLb.textColor = KeyboardColors(colorScheme: getColorScheme()).unselectedTextIconColor
            (collectionView.cellForItem(at: indexPath) as? UntilityKeyboardCell)?.borderView.backgroundColor = KeyboardColors(colorScheme: getColorScheme()).unselectedBackgroundIconView
        }
    }
    
    private func callVNPTAPI(){
        self.showLoading()
        vm.callAPIVNPT(successCls: {[weak self] resp in
            self?.hideLoading()
            self?.descriptionLB.text = "isp: \(resp.isp ?? "") - org: \(resp.org ?? "") - as: \(resp.ast ?? "") in \(resp.city ?? ""), \(resp.country ?? "")"
            self?.showPopup(titleStr: "Thông tin chi tiết", contentStr: "isp: \(resp.isp ?? "") - org: \(resp.org ?? "") - as: \(resp.ast ?? "") in \(resp.city ?? ""), \(resp.country ?? "")")
        }, failCls: { [weak self] errorStr in
            //show error alert
            self?.hideLoading()
            self?.descriptionLB.text = errorStr
            self?.showPopup(titleStr: "Lỗi", contentStr: errorStr)
        })
    }
    
    private func getContacts(collectionView: UICollectionView, indexPath: IndexPath) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        vm.loadJson(filename: "contacts", success: { [weak self] count in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self?.view ?? UIView(), animated: true)
                self?.selectedUntilityLb.text = "\((collectionView.cellForItem(at: indexPath) as? UntilityKeyboardCell)?.textLb.text ?? "") (\(count))"
            }
            
        }, fail: {
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.selectedUntilityLb.text = (collectionView.cellForItem(at: indexPath) as? UntilityKeyboardCell)?.textLb.text
            }
        })
    }
}

extension KeyboardViewController {
    func setColorScheme(_ colorScheme: KeyboardColorScheme) {
        let colorScheme = KeyboardColors(colorScheme: colorScheme)
        selectedUntilityLb.textColor = colorScheme.previewTextColor
        descriptionLB.textColor = colorScheme.previewTextColor
        view.backgroundColor = colorScheme.backgroundColor
        displayNumberLb.textColor = colorScheme.previewTextColor
    }
    
    func showLoading(_ msg: String? = nil) {
        hideLoading()
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            if let m = msg {
                hud.label.text = m
            }
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func showPopup(titleStr: String, contentStr: String){
        DispatchQueue.main.async {
//            let vc = BasicPopup()
//            vc.titleStr = titleStr
//            vc.contentStr = contentStr
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
            let popup = Bundle.main.loadNibNamed("BasicPopupView", owner: self, options: nil)?.first as! BasicPopupView
            popup.setupView(titleStr: titleStr, contentStr: contentStr, isDarkMode: self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearance.dark)
            popup.frame = CGRect(x:0, y: self.view.frame.height + 10, width: self.view.frame.width, height: self.view.frame.height)
            UIView.transition(with: self.view, duration: 0.25, options: [.curveEaseIn], animations: {
                popup.frame = CGRect(x:0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: nil)
            self.view.addSubview(popup)
            popup.copyInfomation = { [weak self] info in
                UIPasteboard.general.string = info
                self?.showToast(message: "Copy info successful", font: UIFont.systemFont(ofSize: 12))
            }
            popup.closePopup = {
                UIView.transition(with: self.view, duration: 0.5, options: [.curveEaseIn], animations: {
                    popup.frame = CGRect(x:0, y: self.view.frame.height + 10, width: self.view.frame.width, height: self.view.frame.height)
                }, completion: {_ in
                    popup.removeFromSuperview()
                })
            }
            
        }
    }
    
    func showPopupEnterNumber(){
        let viewAn = UIView()
        viewAn.backgroundColor = .blue
        viewAn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewAn)
        NSLayoutConstraint.activate([
            viewAn.leftAnchor.constraint(equalTo: self.displayNumberLb.leftAnchor, constant: self.displayNumberLb.text?.width(withConstrainedHeight: 32, font: UIFont.systemFont(ofSize: 17)) ?? 0),
            viewAn.topAnchor.constraint(equalTo: self.displayNumberLb.topAnchor, constant: 6),
            viewAn.bottomAnchor.constraint(equalTo: self.displayNumberLb.bottomAnchor, constant: -6),
            viewAn.widthAnchor.constraint(equalToConstant: 1.5)
        ])
        UIView.animate(withDuration: 1, delay: 0.2, options: .repeat, animations: {
            viewAn.alpha = 0
        }, completion: { _ in
            viewAn.alpha = 1
        })
        let popup = Bundle.main.loadNibNamed("EnterPhoneView", owner: self, options: nil)?.first as! EnterPhoneView
        popup.frame = CGRect(x:0, y: self.view.frame.height + 10, width: self.view.frame.width, height: self.view.frame.height)
        UIView.transition(with: self.view, duration: 0.25, options: [.curveEaseIn], animations: {
            popup.frame = CGRect(x:0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
        self.view.addSubview(popup)
        popup.setUpView(currentNum: self.displayNumberLb.text)
        popup.closePopup = { [unowned self] numberStr in
            UIView.transition(with: self.view, duration: 0.5, options: [.curveEaseIn], animations: {
                popup.frame = CGRect(x:0, y: self.view.frame.height + 10, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: { [weak self]_ in
                popup.removeFromSuperview()
                if numberStr != "" {
                    self?.tfPhone.placeholder  = ""
                }else {
                    self?.tfPhone.placeholder  = "Enter number"
                }
                self?.displayNumberLb.text = numberStr
                viewAn.removeFromSuperview()
            })
        }
    }
}

extension KeyboardViewController: NSFilePresenter {
    func writeToFile(urlStr: String){
        let coordinator = NSFileCoordinator(filePresenter: self)
        coordinator.coordinate(writingItemAt: presentedItemURL!, options: .forReplacing, error: nil) { url in
            do {
                try urlStr.write(to: url, atomically: false, encoding: .utf8)
            }
            catch {
                print("writing failed")
                
            }
        }
    }
}



