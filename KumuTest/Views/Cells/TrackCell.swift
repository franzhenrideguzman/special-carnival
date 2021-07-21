//
//  TrackCell.swift
//  KumuTest
//
//  Created by Franz Henri De Guzman on 7/15/21.
//

import UIKit
import Kingfisher

class TrackCell: UITableViewCell {

    static let identifier = "TrackCell"
    
    @IBOutlet weak var imageUrlView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var backgroundContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundContentView.layer.cornerRadius = 10.0
        imageUrlView.layer.cornerRadius = imageUrlView.frame.size.height/2.0
        
        backgroundContentView.layer.shadowPath = UIBezierPath(rect: backgroundContentView.bounds).cgPath
        backgroundContentView.layer.shadowRadius = 5
        backgroundContentView.layer.shadowOffset = .zero
        backgroundContentView.layer.shadowOpacity = 1
        backgroundContentView.layer.shouldRasterize = true
        backgroundContentView.layer.rasterizationScale = UIScreen.main.scale
    }

    func configure(model: AppStoreItem) {
        
        if let trackName = model.trackName {
            trackNameLabel.text = trackName
        } else {
            trackNameLabel.text = "<no track name>"
        }
        
        if let primaryGenreName = model.primaryGenreName {
            genreLabel.text = primaryGenreName
        } else {
            genreLabel.text = "<no genre>"
        }
        
        if let trackPrice = model.trackPrice,
           let currency = model.currency {
            priceLabel.text = String(trackPrice) + " " + String(currency)
        } else {
            priceLabel.text = "<no price>"
        }
        
        if let url = model.artworkUrl60 {
            setImageURL(url: url)
        }
        
    }
    
    fileprivate func setImageURL(url: String) {
        if let url = URL(string: url) {
            imageUrlView.kf.setImage(with: url, placeholder: nil, options: .none, progressBlock: nil)
        }
    }
    
}
