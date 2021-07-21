//
//  Bundle+Extension.swift
//  KumuTest
//
//  Created by Franz Henri De Guzman on 7/18/21.
//

import UIKit

extension Bundle {
    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}
