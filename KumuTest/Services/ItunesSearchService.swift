//
//  ItunesSearchService.swift
//  KumuTest
//
//  Created by Franz Henri De Guzman on 7/14/21.
//

import UIKit
import RxAlamofire
import Alamofire
import SwiftyJSON
import RxSwift


protocol ItunesSearchServiceProtocol {
    func searchItunes(term: String, country: String, mediaType: String) -> Observable<[AppStoreItem]>
}

class ItunesSearchService: ItunesSearchServiceProtocol {

    /// The Search API allows you to place search fields in your website to search for content within the iTunes Store and Apple Books Store. You can search for a variety of content; including books, movies, podcasts, music, music videos, audiobooks, and TV shows.
    ///
    /// - Parameters:
    ///     - term: The URL-encoded text string you want to search for. For example: jack+johnson.
    ///     - country: The two-letter country code for the store you want to search.
    ///     - mediaType: The media type you want to search for. For example: movie. The default is all..
    /// - Returns Observable<[AppStoreItem]>
    func searchItunes(term: String, country: String, mediaType: String) -> Observable<[AppStoreItem]> {

        return RxAlamofire.requestData(APIRouter.searchItunes(term, country, mediaType)).compactMap { (response, data) -> [AppStoreItem] in
            do {
                let val = try JSONDecoder().decode(AppStoreItems.self, from: data)
                return val.appStoreItems
            } catch {
                debugPrint("Error is \(error)")
            }
            return []
        }
    }
    
    
}
