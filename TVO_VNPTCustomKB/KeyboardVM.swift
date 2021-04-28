//
//  KeyboardVM.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 4/28/21.
//

import Foundation

class KeyboardVM {
    func loadJson(filename fileName: String, success: ((Int)->())?, fail: (()->())?) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                if let success = success {
                    success(jsonData.contacts?.count ?? 0)
                }
            } catch {
                if let fail = fail {
                    fail()
                }
            }
        }else{
            if let fail = fail {
                fail()
            }
        }
    }
}
