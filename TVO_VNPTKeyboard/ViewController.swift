//
//  ViewController.swift
//  TVO_VNPTKeyboard
//
//  Created by Ngavt on 4/27/21.
//

import UIKit
import SwiftyGif

class ViewController: BaseVC, NSFilePresenter, UITextFieldDelegate {

    @IBOutlet weak var testTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var presentedItemURL: URL?
    var presentedItemOperationQueue: OperationQueue = OperationQueue.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let file = "keyboard.txt"
        if let dir = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.tvo.vnpt.demo") {
            presentedItemURL = dir.appendingPathComponent(file)
            // register for presentedItemDidChange work
            NSFileCoordinator.addFilePresenter(self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initView()
    }
    
    func initView(){
        DispatchQueue.main.async {
            self.addCustomBarKeyboard(self.testTextField)
        }
    }
    
    func presentedItemDidChange() { // posted on changed existed file only
        readFromFile()
    }

    private func readFromFile() {
        guard let presentedItemURL = presentedItemURL else {
            return
        }
        let coordinator = NSFileCoordinator(filePresenter: self)
        coordinator.coordinate(readingItemAt: presentedItemURL, options: [], error: nil) { url in
            if let url = try? String(contentsOf: url, encoding: .utf8) {
                let urlLink = URL(string: url)
                if let urlLink = urlLink {
                    DispatchQueue.main.async {
                        self.imageView.isHidden = false
                        self.testTextField.text = url // demo label in view for test
                        let loader = UIActivityIndicatorView(style: .gray)
                        self.imageView.setGifFromURL(urlLink, customLoader: loader)
                    }
                }
                
            } else {
                testTextField.text = ""
//                //just initial creation of file needed to observe following changes

//                }
            }
            coordinator.coordinate(writingItemAt: presentedItemURL, options: .forReplacing, error: nil) { url in
                do {
                    try "".write(to: url, atomically: false, encoding: .utf8)
                }
                catch { print("writing failed") }
            }
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        imageView.isHidden = true
        return true
    }
}

