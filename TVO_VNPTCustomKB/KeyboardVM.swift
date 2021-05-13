//
//  KeyboardVM.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 4/28/21.
//

import Foundation
import UIKit

class KeyboardVM {
    
    func initUntilityList() -> [UntilityModels] {
        let untilityList = [
            UntilityModels(idUntility: "1", nameUntility: "Danh bạ", imageUntility: UIImage(named: "phone_book")),
            UntilityModels(idUntility: "2", nameUntility: "Hạn mức", imageUntility: UIImage(named: "limited_time")),
            UntilityModels(idUntility: "3", nameUntility: "Thông tin tài khoản", imageUntility: UIImage(named: "acc_information")),
            UntilityModels(idUntility: "4", nameUntility: "Chuyển tiền", imageUntility: UIImage(named: "money_growth"))
        ]
        
        return untilityList
    }
    
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
    
    func callAPIVNPT(successCls: ((VNPTModel)->())?, failCls: ((String)->())?){
        VNPTEnpoints.exampleVnpt.sendRequest(
            parsingModelType: VNPTModel.self, success: { (resp) in
                
                if let successCls = successCls {
                    successCls(resp)
                }
            }, failure: { errorStr in
                //show error alert
                if let failCls = failCls {
                    failCls(errorStr)
                }
            })
    }
}
