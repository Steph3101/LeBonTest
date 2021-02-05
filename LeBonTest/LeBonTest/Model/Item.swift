//
//  Item.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import Foundation

struct Item: Codable {
    let id: Int
    let title: String?
    let categoryId: Int?
    let itemDescription: String?
    let price: Int?
    let imagesUrl: ImagesUrl?
    let creationDate: Date?
    let isUrgent: Bool?
    let siret: String?
}

struct ImagesUrl: Codable {
    let small: URL?
    let thumb: URL?
}
