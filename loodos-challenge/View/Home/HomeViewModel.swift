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
        service.getFilms(with: title) { [weak self] in
            guard let strongSelf = self else { return }
            switch $0{
            case .success(let data):
                if data.response == "True"{
                    print(data)
                    if let results = data.search{
                        strongSelf.results = results
                    }
                    strongSelf.state.value = .populate
                } else if data.response == "False"{
                    print(data)
                    strongSelf.state.value = .error
                    strongSelf.showError(message: data.error ?? "No result")
                }
            case .failure(let error):
                print(error.localizedDescription)
                strongSelf.state.value = .error
                strongSelf.showError(message: error.localizedDescription)
            }
        }
    }

    private func showError(message: String) {
        errorState.value = .error(message: message)
    }
}
