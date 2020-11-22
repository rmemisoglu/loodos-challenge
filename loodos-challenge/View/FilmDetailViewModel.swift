//
//  FilmDetailViewModel.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 22.11.2020.
//

import Foundation
class FilmDetailViewModel: BaseViewModel{
    private let service: APIService
    var results = [MovieResponse]()
    var details: Dynamic<MovieResponse?> = Dynamic(nil)
    var imdbId = Constants.Default.empty
    init(service: APIService, imdbId: String) {
        self.service = service
        self.imdbId = imdbId
    }
    
    func getFilmDetail(by imdbId: String) {
        state.value = .loading
        service.getFilmDetail(by: imdbId) { (response) in
            switch response{
            case .success(let data):
                if data.response == "True"{
                    print(data)
                    self.details.value = data
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
