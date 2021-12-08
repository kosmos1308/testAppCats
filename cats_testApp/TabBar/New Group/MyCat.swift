//
//  MyCat.swift
//  cats_testApp
//
//  Created by pavel on 7.12.21.
//

import Foundation

final class MyCat {
    
    static let shared = MyCat()
    
    var myCatsArray: [String] = {
        var myCat = [String]()
        return myCat
    }()
    
    func addMyCat(cat: String) {
        myCatsArray.append(cat)
    }
    
}
