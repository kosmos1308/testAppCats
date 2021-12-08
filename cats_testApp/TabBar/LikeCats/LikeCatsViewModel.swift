//
//  LikeCatsViewModel.swift
//  cats_testApp
//
//  Created by pavel on 7.12.21.
//

import Foundation

protocol LikeCatsViewModelProtocol: AnyObject {
    func numberOfRow() -> Int
    func cellViewModel(at indexPath: IndexPath) -> String
}


final class LikeCatsViewModel: LikeCatsViewModelProtocol {
    func cellViewModel(at indexPath: IndexPath) -> String {
        let myCats = MyCat.shared.myCatsArray[indexPath.row]
        return myCats
    }
    
    func numberOfRow() -> Int {
        MyCat.shared.myCatsArray.count
    }
}



