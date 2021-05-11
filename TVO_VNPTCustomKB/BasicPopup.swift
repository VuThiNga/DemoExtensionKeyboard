//
//  BasicPopup.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 5/9/21.
//

import UIKit

class BasicPopup: UIViewController {

    @IBOutlet weak var popupTitleLb: UILabel!
    @IBOutlet weak var contentTv: UITextView!
    
    var titleStr: String?
    var contentStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.popupTitleLb.text = self.titleStr ?? " "
            self.contentTv.text = self.contentStr ?? " "
        }
    }

    @IBAction func cancelAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
