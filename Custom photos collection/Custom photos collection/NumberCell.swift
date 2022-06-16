//
//  NumberCell.swift
//  Custom photos collection
//
//  Created by Григорий Виняр on 16/06/2022.
//

import UIKit

class NumberCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseID: String = "NumberCell"
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.text = "1"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(numberLabel)
        self.backgroundColor = .purple
        setNumberLabelConstraints()
    }
    
    func configure(with intValue: Int) {
        self.numberLabel.text = "\(intValue)"
    }
    
    private func setNumberLabelConstraints() {
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        numberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
