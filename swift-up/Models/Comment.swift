//
//  Comment.swift
//  swift-up
//
//  Created by Omar barkat on 10/11/2023.
//

import Foundation
import UIKit
struct Comment     : Decodable {
   var id          : String
   var message     : String
   var owner       : User
   var publishDate : String
}
