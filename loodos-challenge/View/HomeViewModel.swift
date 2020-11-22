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
    var routeFilmDetail: Dynamic<FilmDetailViewModel?> = Dynamic(nil)
    
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
                    if let results = data.search{
                        self.results = results
                    }
                    self.state.value = .populate
                } else if data.response == "False"{
                    print(data)
                    self.state.value = .error
                    self.showError(message: data.error ?? "No result")
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.state.value = .error
                self.showError(message: error.localizedDescription)
            }
        }
    }

    private func showError(message: String) {
        errorState.value = .error(message: message)
    }
}
