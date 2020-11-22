//
//  HomeViewModel.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 20.11.2020.
//

import Foundation
class HomeViewModel: BaseViewModel{
    private let service: APIService
    var results = [MovieResponse]()
    var details: Dynamic<MovieResponse?> = Dynamic(nil)

    init(service: APIService) {
        self.service = service
    }
    
    func getFilms(with title: String) {
        state.value = .loading
        service.getFilms(with: title) { (response) in
            switch response{
            case .success(let data):
                if data.response == "True"{
                    print(data)
                    self.results = data.search
                    self.state.value = .populate
                } else if data.response == "False"{
                    print(data)
                    self.state.value = .error
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.state.value = .error
            }
        }
    }

    private func showError(title: String? = nil, message: String? = nil) {
        errorState.value = .error(message: message)
    }
}
