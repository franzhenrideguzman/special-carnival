//
//  HomeViewController.swift
//  KumuTest
//
//  Created by Franz Henri De Guzman on 7/14/21.
//

import UIKit
import RxCocoa

class HomeViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = HomeViewModel()
    var filteredItems: BehaviorRelay<[AppStoreItem]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchData()
        setReactive()
        setUI()
    }
    
    func setUI() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func setReactive() {
        
        self.viewModel.appStoreItems.bind(to: self.filteredItems).disposed(by: disposeBag)
        
        filteredItems.compactMap({ $0.count }).subscribe(onNext:{ [weak self] count in
            if count == 0 {
                UIComponents.emptyTablePlaceholder.titleLabel.text = "Oops"
                UIComponents.emptyTablePlaceholder.subTitleLabel.text = "Cannot find what you are looking for. Try a different word."
                self?.tableView.backgroundView = UIComponents.emptyTablePlaceholder
            } else {
                self?.tableView.backgroundView = UIView()
            }

            self?.tableView.reloadData()
            
        }).disposed(by: disposeBag)
        
        searchBar.rx.text
                .orEmpty
                .subscribe(onNext: {query in
                    
                    let filteredItemsTemp = self.viewModel.appStoreItems.value.filter({(item: AppStoreItem) -> Bool in

                        let stringMatch = item.trackName?.lowercased().range(of: query.lowercased())
                        return stringMatch != nil ? true : false
                    })
                    
                    if query == "" {
                        self.filteredItems.accept(self.viewModel.appStoreItems.value)
                    }
                    else {
                        self.filteredItems.accept(filteredItemsTemp)
                    }
                })
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        filteredItems
            .bind(to: tableView.rx.items(cellIdentifier: TrackCell.identifier, cellType: TrackCell.self)) { (idx, item, cell) in
                
                cell.configure(model: item)
                
            }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] idx in
            
            self?.tableView.deselectRow(at: idx, animated: true)
            
            if let model = self?.filteredItems.value[idx.row] {
                self?.didTapItem(item: model, index: idx.row)
            }
            
        }).disposed(by: disposeBag)
        
    }
}

//MARK: Custom delegates and actions
extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
}
    
//MARK: Custom delegates and actions
extension HomeViewController {
    
    func didTapItem(item: AppStoreItem, index: Int) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc!.model = item
        
        self.present(vc!, animated: true) { }
    }
    
    @objc func dismissKeyboard() {
      view.endEditing(true)
    }
}
