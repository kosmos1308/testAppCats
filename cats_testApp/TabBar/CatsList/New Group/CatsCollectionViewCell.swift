//
//  CatsCollectionViewCell.swift
//  cats_testApp
//
//  Created by pavel on 6.12.21.
//

import UIKit

final class CatsCollectionViewCell: UICollectionViewCell {
    
    static let id = "CatsCollectionViewCell"
    
    lazy var catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemCyan
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Metrics.cornerRadius
        return imageView
    }()
    
    lazy var nameCatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont(name: "Futura", size: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = contentView.bounds
        gradient.contents = catImageView.image?.cgImage
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    
    var viewModel: CatsCollectionViewCellViewModelProtocol! {
        didSet {
            nameCatLabel.text = viewModel?.catName
            guard let url = URL(string: viewModel.imageName) else { return }
            catImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(catImageView)
        contentView.addSubview(nameCatLabel)
        catImageView.layer.addSublayer(gradient)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        catImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        catImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        catImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        catImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
                
        nameCatLabel.leftAnchor.constraint(equalTo: catImageView.leftAnchor, constant: Metrics.left/2).isActive = true
        nameCatLabel.bottomAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: Metrics.bottom/2).isActive = true
        nameCatLabel.rightAnchor.constraint(equalTo: catImageView.rightAnchor, constant: Metrics.right/2).isActive = true
        nameCatLabel.heightAnchor.constraint(equalToConstant: Metrics.heightLabel).isActive = true
    }
}
