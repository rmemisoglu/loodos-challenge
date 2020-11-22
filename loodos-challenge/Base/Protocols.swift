//
//  Coordinator.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 20.11.2020.
//

import Foundation
// MARK: - Protocols
protocol Coordinator {}

protocol Model: Codable {}
protocol ViewModel: ViewModelState {}
protocol ItemViewModel {}


protocol ViewModelState {
    var state: Dynamic<TableViewState> { get }
    var errorState: Dynamic<ErrorState> { get }
    var updateView: Dynamic<Bool> { get }
}

protocol ConfigurableCell {
    static var nibName: String { get }
    static var identifier: String { get }
    func configure(with itemViewModel: ItemViewModel)
}
