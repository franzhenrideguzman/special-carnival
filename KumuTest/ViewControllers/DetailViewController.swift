//
//  DetailViewController.swift
//  KumuTest
//
//  Created by Franz Henri De Guzman on 7/14/21.
//

import UIKit

class DetailViewController: BaseViewController {

    var model: AppStoreItem?
    fileprivate var favorites = PersistenceManager.shared.favorites
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var addToFavoritesButton: UIButton!
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (model != nil) {
            setUI(model: model!)
        }
    }
    
    fileprivate func setUI(model: AppStoreItem) {
        
        if let trackName = model.trackName {
            titleLabel.text = trackName
        } else {
            titleLabel.text = "<no track name>"
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
        
        if let description = model.description {
            descriptionLabel.text = description
        } else {
            if let longDescription = model.longDescription {
                descriptionLabel.text = longDescription
            } else {
                descriptionLabel.text = "<no description>"
            }
        }
        
        if let url = model.artworkUrl100 {
            setImageURL(url: url)
        }
        
        if let trackId = model.trackId {
            if favorites.filter({ $0.trackId == trackId }).first == nil {
                addToFavoritesButton.setTitle("Add to favorites", for: .normal)
            } else {
                addToFavoritesButton.setTitle("Remove from favorites", for: .normal)
            }
        }
        
    }
    
    fileprivate func setImageURL(url: String) {
        if let url = URL(string: url) {
            bannerImageView.kf.setImage(with: url, placeholder: nil, options: .none, progressBlock: nil)
        }
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addToFavoritesTapped(_ sender: Any) {
        if let trackId = model?.trackId {
            if let object = favorites.filter({ $0.trackId == trackId }).first {
                favorites.remove(at: favorites.firstIndex(of: object)!)
                addToFavoritesButton.setTitle("Add to favorites", for: .normal)
            } else {
                favorites.append(model!)
                addToFavoritesButton.setTitle("Remove from favorites", for: .normal)
            }
        }
        
        PersistenceManager.shared.favorites = favorites
    }
}
