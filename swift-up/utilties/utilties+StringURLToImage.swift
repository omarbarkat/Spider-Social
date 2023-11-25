//
//  utilties+StringURLToImage.swift
//  swift-up
//
//  Created by Omar barkat on 11/11/2023.
//

import Foundation
import UIKit

extension UIImageView {
    func SetImageFromURL (stringimg : String) {
        if let url = URL(string: stringimg){
            if   let data = try? Data(contentsOf: url) {
                self.image = UIImage(data: data)

            }
        }
    }
    func makeCircularImage () {
        self.layer.cornerRadius = self.frame.width / 2
    }
}
