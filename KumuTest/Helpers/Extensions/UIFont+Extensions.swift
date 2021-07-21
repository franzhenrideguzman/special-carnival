//
//  UIFont+Extensions.swift
//  KumuTest
//
//  Created by Franz Henri De Guzman on 7/18/21.
//

import UIKit

extension UIFont {
    
    func regularFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    func boldFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
}
