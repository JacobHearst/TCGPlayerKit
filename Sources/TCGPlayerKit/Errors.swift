//
//  File.swift
//  
//
//  Created by Jacob Hearst on 12/10/21.
//

import Foundation

public enum TCGPlayerKitError: Error, CustomStringConvertible {
    public case networkingError(String)
    public case emptyIds

    var description: String {
        switch self {
        case .networkingError(let description):
            return "Networking error: \(description)"
        case .emptyIds:
            return "Received an empty list of ids to get data for"
        }
    }
}
