//
//  CatDetailViewModel.swift
//  cats_testApp
//
//  Created by pavel on 6.12.21.
//

import Foundation
import UIKit

protocol CatDetailViewModelProtocol: AnyObject {
    var name: String { get }
    var imageName: String { get }
    var isLike: Bool { get }
    var viewModelDidChange: ((CatDetailViewModelProtocol) -> Void)? { get set }
    init(cat: Cat)
    func likeButtonPressed()
    func saveImageButtonPressed(image: UIImage)
}

final class CatDetailViewModel: CatDetailViewModelProtocol {
    var name: String {
        cat.name
    }
    
    var imageName: String {
        cat.image.url
    }
    
    var isLike: Bool {
        get {
            DataManager.shared.getLikeStatus(for: cat.name)
        } set {
            DataManager.shared.setLikeStatus(for: cat.name, with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var viewModelDidChange: ((CatDetailViewModelProtocol) -> Void)?
    private let cat: Cat
    var likeCat: [MyCat] = []
    
    required init(cat: Cat) {
        self.cat = cat
    }
    
    func likeButtonPressed() {
        isLike.toggle()
    
        if isLike == true {
            MyCat.shared.addMyCat(cat: cat.name)
        } else {
            if MyCat.shared.myCatsArray.count != 0 {
                var index = -1
                for nameCat in MyCat.shared.myCatsArray {
                    index += 1
                    if nameCat == cat.name {
                        MyCat.shared.myCatsArray.remove(at: index)
                    }
                }
            }
        }
    }
    
    func saveImageButtonPressed(image: UIImage) {
        let img = image
        let directoryPath = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let imageData = img.jpegData(compressionQuality: 1)
        guard let directoryPath = directoryPath else { return }
        let imagePath = directoryPath.path + "/\(cat.name).jpeg"
        FileManager.default.createFile(atPath: imagePath, contents: imageData, attributes: nil)
        print("Your image has been saved \(directoryPath)")
    }
}
