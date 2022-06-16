//
//  Albums.swift
//  Custom photos collection
//
//  Created by Григорий Виняр on 16/06/2022.
//

import UIKit

struct Albums: Decodable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}
