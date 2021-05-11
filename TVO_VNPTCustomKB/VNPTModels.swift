//
//  VNPTModels.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 5/7/21.
//

import Foundation
import ObjectMapper

struct VNPTModel : Mappable {
    var status : String?
    var country : String?
    var countryCode : String?
    var region : String?
    var regionName : String?
    var city : String?
    var zip : String?
    var lat : Double?
    var lon : Double?
    var timezone : String?
    var isp : String?
    var org : String?
    var ast : String?
    var query : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["status"]
        country <- map["country"]
        countryCode <- map["countryCode"]
        region <- map["region"]
        regionName <- map["regionName"]
        city <- map["city"]
        zip <- map["zip"]
        lat <- map["lat"]
        lon <- map["lon"]
        timezone <- map["timezone"]
        isp <- map["isp"]
        org <- map["org"]
        ast <- map["as"]
        query <- map["query"]
    }
}
