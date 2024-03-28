//
//  MainCollectionViewCellModel.swift
//  ProfileTask
//
//  Created by Danil Komarov on 28.03.2024.
//

import Foundation

struct MainCollectionViewCellModel: Hashable, Codable {
    let name: String?
    let description: String?
    let link: String?
    let iconURL: String?
    var iconData: Data?
}
