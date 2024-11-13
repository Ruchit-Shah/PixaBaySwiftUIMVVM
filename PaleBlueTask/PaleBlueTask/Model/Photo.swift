//
//  Photo.swift
//  PaleBlueTask
//
//  Created by Shah Ruchit Bhadreshbhai on 04/10/24.
//

struct Photo: Identifiable, Decodable {
    let id: Int
    let user: String
    let previewURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case user
        case previewURL = "previewURL"
    }
}
