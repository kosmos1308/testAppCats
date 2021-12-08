//
//  CatsViewController.swift
//  cats_testApp
//
//  Created by pavel on 6.12.21.
//

import UIKit
import SDWebImage

final class CatsViewController: UIViewController {
    
    let spacing: CGFloat = 10
    var cats: [Cat] = []
 
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    private var viewModel: CatsListViewModelProtocol! {
        didSet {
            viewModel?.fetchCats { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        viewModel = CatsListViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(collectionView)
        updateNavBar()
        
        collectionView.register(CatsCollectionViewCell.self, forCellWithReuseIdentifier: CatsCollectionViewCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func updateNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .purple
        title = "Cats"
    }
}

//MARK:  - UICollectionViewDataSource
extension CatsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatsCollectionViewCell.id, for: indexPath)
        guard let catCell = cell as? CatsCollectionViewCell else { return cell }
        catCell.viewModel = viewModel.cellViewModel(at: indexPath)
        
        return catCell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CatsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailViewModel = viewModel.viewModelForSelectedItem(at: indexPath)
        let catDetailVC = CatDetailViewController()
        catDetailVC.viewModel = detailViewModel
        navigationController?.pushViewController(catDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let countItemsPerRow: CGFloat = 2
        let paddingWidth = spacing * (countItemsPerRow + 1)
        let availableWidth = collectionView.bounds.width - paddingWidth
        let widthItem = availableWidth / countItemsPerRow
        
        return CGSize(width: widthItem, height: widthItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
}

