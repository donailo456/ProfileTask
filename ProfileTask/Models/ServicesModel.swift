//
//  ServicesModel.swift
//  ProfileTask
//
//  Created by Danil Komarov on 28.03.2024.
//

import Foundation

// MARK: - ServicesModel

struct ServicesModel: Codable {
    let body: Body?
    let status: Int?
}

// MARK: - Body

struct Body: Codable {
    let services: [Service]?
}

// MARK: - Service

struct Service: Codable {
    let name: String?
    let description: String?
    let link: String?
    let icon_url: String?
}
