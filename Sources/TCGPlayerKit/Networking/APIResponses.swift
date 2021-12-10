//
//  File.swift
//  
//
//  Created by Jacob Hearst on 12/10/21.
//

import Foundation

public struct ProductPriceInfo: Decodable {
    let productId: Int
    let lowPrice: Double?
    let midPrice: Double?
    let highPrice: Double?
    let marketPrice: Double?
    let directLowPrice: Double?
    let subTypeName: String
}

public struct ProductMarketPriceResponse: Decodable {
    let success: Bool
    let errors: [String]
    let results: [ProductPriceInfo]
}

struct BearerToken: Decodable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let userName: String
    let issued: String
    let expires: String

    enum CodingKeys: String, CodingKey {
        case accessToken, tokenType, expiresIn, userName 
        case issued = ".issued"
        case expires = ".expires"
    }
}
