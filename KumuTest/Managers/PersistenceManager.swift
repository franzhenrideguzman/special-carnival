//
//  PersistenceManager.swift
//  KumuTest
//
//  Created by Franz Henri De Guzman on 7/16/21.
//

import Foundation
import RxCocoa

class PersistenceManager
{
    // MARK:- Properties

    public static var shared = PersistenceManager()
    
    var favoritesObservable: BehaviorRelay<[AppStoreItem]> = BehaviorRelay(value: [])
    
    var favorites: [AppStoreItem]
    {
        get
        {
            guard let data = UserDefaults.standard.data(forKey: UserDefaultKeys.favorites) else { return [] }
            favoritesObservable.accept((try? JSONDecoder().decode([AppStoreItem].self, from: data)) ?? [])
            return (try? JSONDecoder().decode([AppStoreItem].self, from: data)) ?? []
        }
        set
        {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            favoritesObservable.accept(newValue)
            UserDefaults.standard.set(data, forKey: UserDefaultKeys.favorites)
        }
    }

    // MARK:- Init

    private init(){
        favoritesObservable.accept(favorites)
    }
}
