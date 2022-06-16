//
//  ImageCell.swift
//  Custom photos collection
//
//  Created by Григорий Виняр on 16/06/2022.
//

import UIKit

class ImageCell: UICollectionViewCell, SelfConfiguringCell {
    
    static let reuseID: String = "ImageCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        imageView.image = UIImage(systemName: "car", withConfiguration: boldConfig)
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        setupImageViewConstraints()
    }
    
    private func setupImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    func configure(with intValue: Int) {
        print("intValue")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
