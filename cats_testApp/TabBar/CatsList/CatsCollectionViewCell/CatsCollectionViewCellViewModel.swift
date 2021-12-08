//
//  CatsCollectionViewCellViewModel.swift
//  cats_testApp
//
//  Created by pavel on 6.12.21.
//

import Foundation

protocol CatsCollectionViewCellViewModelProtocol {
    var catName: String { get }
    var imageName: String { get }

    init(cat: Cat)
}

final class CatsCollectionViewCellViewModel: CatsCollectionViewCellViewModelProtocol {
    
    var catName: String {
        cat.name
    }
    
    var imageName: String {
        cat.image.url
    }
    
    private let cat: Cat
    
    required init(cat: Cat) {
        self.cat = cat
    }
}
