//
//  CatDetailViewController.swift
//  cats_testApp
//
//  Created by pavel on 6.12.21.
//

import UIKit

final class CatDetailViewController: UIViewController {
    
    private lazy var nameCatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemPurple
        label.font = UIFont(name: "Futura Bold", size: 20)
        return label
    }()
    
    private lazy var catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Metrics.cornerRadius
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .infoDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart.circle"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 0,
                                              bottom: 0,
                                              right: 0)
        button.backgroundColor = .clear
        button.addTarget(self,
                         action: #selector(likeButtonPressed),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var saveImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Metrics.cornerRadius
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont(name: "Futura Bold", size: 20)
        button.backgroundColor = .systemPurple
        button.addTarget(self,
                         action: #selector(saveImageButtonPressed),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var saveImageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.text = "Your image has been saved"
        label.font = UIFont(name: "Futura", size: 16)
        label.alpha = 0
        return label
    }()
        
    var viewModel: CatDetailViewModelProtocol!
    var cat: Cat?
    
    override func loadView() {
        super.loadView()
        guard let cat = cat else { return }
        viewModel = CatDetailViewModel(cat: cat)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(nameCatLabel)
        view.addSubview(catImageView)
        view.addSubview(likeButton)
        view.addSubview(saveImageButton)
        view.addSubview(saveImageLabel)
        setupAutoLayout()
        setupUI()
    }
    
    
    func setupUI() {
        setStatusForLikeButton()
        viewModel.viewModelDidChange = { [weak self] viewModel in
            self?.setStatusForLikeButton()
        }
        nameCatLabel.text = viewModel.name
        guard let url = URL(string: viewModel.imageName) else { return }
        catImageView.sd_setImage(with: url, completed: nil)
    }
    
    @objc private func likeButtonPressed() {
        viewModel.likeButtonPressed()
    }
    
    private func setStatusForLikeButton() {
        likeButton.tintColor = viewModel.isLike ? .systemPurple : .white
    }
    
    @objc func saveImageButtonPressed(image: UIImage) {
        guard let image = catImageView.image else {return}
        viewModel.saveImageButtonPressed(image: image)
        saveImageLabel.alpha = 1
        if saveImageLabel.alpha == 1 {
            UIView.animate(withDuration: 3) {
                self.saveImageLabel.alpha = 0
            }
        }
    }
    
    private func setupAutoLayout() {
        catImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        catImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.topImageView).isActive = true
        catImageView.heightAnchor.constraint(equalToConstant: Metrics.heightImage).isActive = true
        catImageView.widthAnchor.constraint(equalToConstant: Metrics.widthImage).isActive = true
        
        nameCatLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameCatLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Metrics.left).isActive = true
        nameCatLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Metrics.right).isActive = true
        nameCatLabel.heightAnchor.constraint(equalToConstant: Metrics.heightLabel*2).isActive = true
        nameCatLabel.bottomAnchor.constraint(equalTo: catImageView.topAnchor, constant: Metrics.bottom).isActive = true
        
        likeButton.rightAnchor.constraint(equalTo: catImageView.rightAnchor, constant: Metrics.right/2).isActive = true
        likeButton.bottomAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: Metrics.bottom/2).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: Metrics.heightButton).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: Metrics.widthButton).isActive = true
        
        saveImageButton.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: Metrics.top).isActive = true
        saveImageButton.centerXAnchor.constraint(equalTo: catImageView.centerXAnchor).isActive = true
        saveImageButton.heightAnchor.constraint(equalToConstant: Metrics.heightButton).isActive = true
        saveImageButton.widthAnchor.constraint(equalToConstant: Metrics.widthImage).isActive = true
        
        saveImageLabel.topAnchor.constraint(equalTo: saveImageButton.bottomAnchor, constant: Metrics.top/2).isActive = true
        saveImageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Metrics.left).isActive = true
        saveImageLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Metrics.right).isActive = true
        saveImageLabel.heightAnchor.constraint(equalToConstant: Metrics.heightLabel).isActive = true
    }
}
