//
//  VNPTEndpoints.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 5/7/21.
//

import Foundation
import Moya

enum VNPTEnpoints {
    case exampleVnpt
    
}

extension VNPTEnpoints: TargetType {
    
    var task: Task {
        return .requestPlain
    }
    
    var method: Moya.Method {
        return .get
    }
    
    public var path: String {
        return "/json"
    }
}
