//
//  BasicPopupView.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 5/9/21.
//

import UIKit

class BasicPopupView: UIView {
    @IBOutlet weak var popupTitleLb: UILabel!
    @IBOutlet weak var contentTv: UITextView!
    @IBOutlet weak var closeBtn: UIButton!
    
    var closePopup:(() -> ())?
    var copyInfomation: ((String)->())?
    
    func setupView(titleStr: String, contentStr: String, isDarkMode: Bool = false) {
        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.closeBtn.tintColor = isDarkMode ? .white : .black
            self.popupTitleLb.text = titleStr
            self.contentTv.text = contentStr
            //event
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.copyInformation(tapGestureRecognizer:)))
            self.contentTv.isUserInteractionEnabled = true
            self.contentTv.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func copyInformation(tapGestureRecognizer: UITapGestureRecognizer) {
        if let copyInfomation = copyInfomation {
            copyInfomation(contentTv.text.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
    
    @IBAction func closeAct(_ sender: Any) {
        if let close = closePopup {
            close()
        }
    }
    
}
