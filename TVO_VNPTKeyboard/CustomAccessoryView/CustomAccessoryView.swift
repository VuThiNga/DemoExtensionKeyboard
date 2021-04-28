//
//  CustomAccessoryView.swift
//  TVO_VNPTKeyboard
//
//  Created by Ngavt on 4/27/21.
//

import UIKit

class CustomAccessoryView: UIView {

    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var accountTf: UITextField!
    
    var addAction: ((String)->())?
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.setup()
    }

    override init(frame: CGRect) {

        super.init(frame: frame)

        self.setup()
    }

    private func setup() {

        let view = self.viewFromNibForClass()

        view?.frame = self.bounds

        view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        if let view = view {

            self.addSubview(view)

        }
        
        addBtn.addTarget(self, action: #selector(addAct), for: .touchUpInside)

    }
    
    @objc func addAct(){
        //do something
        if let addAction = addAction {
            addAction(accountTf.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        }
    }

    override func didMoveToWindow() {

        super.didMoveToWindow()

        if let window = self.window {

            self.bottomAnchor.constraint(lessThanOrEqualTo: window.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }

    private func viewFromNibForClass() -> UIView? {

        let bundle = Bundle(for: type(of: self))

        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)

        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView

        return view
    }

}
