//
//  SelfConfiguringCell.swift
//  Custom photos collection
//
//  Created by Григорий Виняр on 16/06/2022.
//

import UIKit

protocol SelfConfiguringCell {
    static var reuseID: String { get }
    func configure(with intValue: Int)
}

