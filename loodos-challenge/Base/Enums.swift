//
//  Enums.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 20.11.2020.
//

import Foundation
enum TableViewState {
    case loading
    case populate
    case empty
    case error
}

enum ErrorState: Error {
    case error(message: String)
    case none
}
