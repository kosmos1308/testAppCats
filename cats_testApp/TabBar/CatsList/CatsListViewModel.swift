//
//  CatsListViewModel.swift
//  cats_testApp
//
//  Created by pavel on 6.12.21.
//

import Foundation

protocol CatsListViewModelProtocol: AnyObject {
    var cats: [Cat] { get }
    func fetchCats(completion: @escaping() -> Void)
    func numberOfItems() -> Int
    func cellViewModel(at indexPath: IndexPath) -> CatsCollectionViewCellViewModelProtocol
    func viewModelForSelectedItem(at indexPath: IndexPath) -> CatDetailViewModelProtocol
}


final class CatsListViewModel: CatsListViewModelProtocol {
    
    var cats: [Cat] = []
    
    func fetchCats(completion: @escaping () -> Void) {
        NetworkingManager.shared.fetchData { [weak self] cats in
            self?.cats = cats
            completion()
        }
    }
    
    func numberOfItems() -> Int {
        cats.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CatsCollectionViewCellViewModelProtocol {
        let cats = cats[indexPath.item]
        return CatsCollectionViewCellViewModel(cat: cats)
    }
    
    func viewModelForSelectedItem(at indexPath: IndexPath) -> CatDetailViewModelProtocol {
        let cats = cats[indexPath.item]
        return CatDetailViewModel(cat: cats)
    }
}
