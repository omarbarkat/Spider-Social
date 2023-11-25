//
//  UserInfo.swift
//  swift-up
//
//  Created by Omar barkat on 12/11/2023.
//

import Foundation
import UIKit
struct UserInfo     : Decodable {
    var id          : Post
    var title       : String
    var firstName   : String
    var lastName    : String
    var picture     : String
    var gender      : String
    var email       : String
    var dateOfBirth : String
    var phone       : String
    var city        : Location
    var country     : Location
    var updatedDate : String
}
