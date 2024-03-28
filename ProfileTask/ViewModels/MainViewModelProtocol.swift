//
//  MainViewModelProtocol.swift
//  ProfileTask
//
//  Created by Danil Komarov on 28.03.2024.
//

import Foundation

protocol MainViewModelProtocol {
    func getServices()
    func paginationData(limit: Int)
}
