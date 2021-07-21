//
//  EmptyPlaceholderView.swift
//  KumuTest
//
//  Created by Franz Henri De Guzman on 7/18/21.
//

import UIKit

class EmptyPlaceholderView: UIView {
    static let nib = Bundle.loadView(fromNib: "EmptyPlaceholderView", withType: EmptyPlaceholderView.self)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = Properties.Color.white
        titleLabel.font = UIFont().boldFont(size: 17)
        titleLabel.textColor = Properties.Color.darkGray
        subTitleLabel.font = UIFont().regularFont(size: 14)
        subTitleLabel.textColor = Properties.Color.lightGray
    }
}

