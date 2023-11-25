//
//  ShadowView.swift
//  swift-up
//
//  Created by Omar barkat on 11/11/2023.
//

import UIKit

class ShadowView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShadow()
    }
    func setupShadow () {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
    }
}
