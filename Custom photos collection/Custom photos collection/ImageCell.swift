//
//  ImageCell.swift
//  Custom photos collection
//
//  Created by Григорий Виняр on 16/06/2022.
//

import UIKit

class ImageCell: UICollectionViewCell, SelfConfiguringCell {
    
    static let reuseID: String = "ImageCell"
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.text = "1"
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(numberLabel)
        setNumberLabelConstraints()
    }
    
    private func setNumberLabelConstraints() {
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        numberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        numberLabel.widthAnchor.constraint(equalToConstant: self.frame.width - 50).isActive = true
    }
    
    func configure(with image: UIImage, title: String) {
        self.numberLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
