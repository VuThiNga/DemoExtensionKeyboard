//
//  UntilityModels.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 4/27/21.
//

import Foundation
import UIKit

final class UntilityModels {
    var idUntility: String
    var nameUntility: String
    var isDisplay: Bool = true
    var imageUntility: UIImage?
    
    init(idUntility: String, nameUntility: String, isDisplay: Bool = true, imageUntility: UIImage? = nil) {
        self.idUntility = idUntility
        self.nameUntility = nameUntility
        self.isDisplay = isDisplay
        self.imageUntility = imageUntility
    }
}

class ResponseData: Decodable {
    var contacts: [ContactModel]?
}

class ContactModel: Decodable {
    var name: String?
    var phone: String?
}
