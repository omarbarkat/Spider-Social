//
//  Post.swift
//  swift-up
//
//  Created by Omar barkat on 08/11/2023.
//

import Foundation
import UIKit
struct Post   : Decodable {
    var id    : String
    var image : String?
    var likes : Int
    var text  : String
    var owner : User?
    var tags  : [String]?
}
