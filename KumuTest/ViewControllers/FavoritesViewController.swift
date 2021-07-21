//
//  FavoritesViewController.swift
//  KumuTest
//
//  Created by Franz Henri De Guzman on 7/15/21.
//

import UIKit
import RxCocoa

class FavoritesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setReactive()
    }

    func setReactive() {
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    
        PersistenceManager.shared.favoritesObservable
            .bind(to: tableView.rx.items(cellIdentifier: TrackCell.identifier, cellType: TrackCell.self)) { (idx, item, cell) in
                
                cell.configure(model: item)
                
            }.disposed(by: disposeBag)
        
        PersistenceManager.shared.favoritesObservable.compactMap({ $0.count }).subscribe(onNext:{ [weak self] count in
            if count == 0 {
                UIComponents.emptyTablePlaceholder.titleLabel.text = "Favorites"
                UIComponents.emptyTablePlaceholder.subTitleLabel.text = "You don't have any favorites yet. All your favorites will show up here."
                self?.tableView.backgroundView = UIComponents.emptyTablePlaceholder
            } else {
                self?.tableView.backgroundView = UIView()
            }

            self?.tableView.reloadData()
            
        }).disposed(by: disposeBag)

        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] idx in
            
            self?.tableView.deselectRow(at: idx, animated: true)
            
            let model = PersistenceManager.shared.favoritesObservable.value[idx.row]
            self?.didTapItem(item: model, index: idx.row)
            
        }).disposed(by: disposeBag)
    }
    
}

//MARK: Custom delegates and actions
extension FavoritesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
}
    
//MARK: Custom delegates and actions
extension FavoritesViewController {
    
    func didTapItem(item: AppStoreItem, index: Int) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc!.model = item
        
        self.present(vc!, animated: true) { }
    }
}
