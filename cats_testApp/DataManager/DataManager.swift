//
//  DataManager.swift
//  cats_testApp
//
//  Created by pavel on 7.12.21.
//

import Foundation
import UIKit

final class DataManager {
    
    static let shared = DataManager()
    private let userDefaults = UserDefaults()
    private init() {}
    
    func setLikeStatus(for catName: String, with status: Bool) {
        userDefaults.set(status, forKey: catName)
    }
    
    func getLikeStatus(for catName: String) -> Bool {
        userDefaults.bool(forKey: catName)
    }
}
