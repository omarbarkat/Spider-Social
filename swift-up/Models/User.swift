//
//  User.swift
//  swift-up
//
//  Created by Omar barkat on 08/11/2023.
//

import Foundation
import UIKit
struct  User        : Decodable {
    var firstName   : String
    var lastName    : String
    var picture     : String?
    var id          : String
    var updatedDate : String?
    var phone       : String?
    var gender      : String?
    var email       : String?
    var dateOfBirth : String?
    var location    : Location?
    var title       : String?

}
