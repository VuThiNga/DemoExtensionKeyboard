//
//  EnterPhoneView.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 5/14/21.
//

import UIKit

class EnterPhoneView: UIView {

    @IBOutlet var numberButtonArray: [UIButton]!
    @IBOutlet weak var displayLb: UILabel!
    var closePopup:((String) -> ())?
    var currentNum: String?
    
    @IBAction func acceptAct(_ sender: Any) {
        if let close = closePopup {
            close(displayLb.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        }
    }
    
    func setUpView(currentNum: String?){
        displayLb.text = currentNum ?? ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for button in numberButtonArray {
            button.addTarget(self, action: #selector(keyPressedAct), for: .touchUpInside)
        }
    }
    @IBAction func clearAct(_ sender: Any) {
        if displayLb.text != "" {
            displayLb.text?.removeLast()
        }
    }
    
    @objc func keyPressedAct(_ sender: UIButton, event: UIEvent){
        displayLb.text?.append(sender.titleLabel?.text ?? "")
    }
}


