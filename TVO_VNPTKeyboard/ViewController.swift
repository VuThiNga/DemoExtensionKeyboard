//
//  ViewController.swift
//  TVO_VNPTKeyboard
//
//  Created by Ngavt on 4/27/21.
//

import UIKit

class ViewController: BaseVC {

    @IBOutlet weak var testTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
    }
    
    func initView(){
        addCustomBarKeyboard(testTextField)
    }

}

