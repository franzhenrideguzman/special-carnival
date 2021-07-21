//
//  HomeViewModel.swift
//  KumuTest
//
//  Created by Franz Henri De Guzman on 7/14/21.
//

import UIKit
import RxSwift
import RxCocoa

struct AppStoreItem:Codable, Equatable {
    var trackName: String?
    var trackId: Int?
    var artworkUrl60: String?
    var artworkUrl100: String?
    var trackPrice: Double?
    var currency: String?
    var primaryGenreName: String?
    var description: String?
    var longDescription: String?
}

struct AppStoreItems: Codable, Equatable {
    let appStoreItems: [AppStoreItem]
    
    enum CodingKeys: String, CodingKey {
        case appStoreItems = "results"
    }
}

struct HomeViewModel {

    let service = ItunesSearchService()
    let appStoreItems: BehaviorRelay<[AppStoreItem]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    /**
     Fetch appStoreItem and bind to appStoreItems variable.
     */
    func fetchData() {
        service.searchItunes(term: "star", country: "au", mediaType: "").bind(to: appStoreItems).disposed(by: disposeBag)
    }
}
