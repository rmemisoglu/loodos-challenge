//
//  BaseViewModel.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 20.11.2020.
//

import Foundation
class BaseViewModel: ViewModel {
    // MARK: - State Notifiers
    private(set) var state: Dynamic<TableViewState> = Dynamic(.loading)
    private(set) var errorState: Dynamic<ErrorState> = Dynamic(.none)
    private(set) var updateView: Dynamic<Bool> = Dynamic(false)
}
