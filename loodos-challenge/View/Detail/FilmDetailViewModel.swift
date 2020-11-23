//
//  FilmDetailViewModel.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 22.11.2020.
//

import Foundation
class FilmDetailViewModel: BaseViewModel{
    private let service: APIService
    var details: Dynamic<MovieResponse?> = Dynamic(nil)
    var imdbId = Constants.Default.empty
    
    init(service: APIService, imdbId: String) {
        self.service = service
        self.imdbId = imdbId
    }
    
    func getFilmDetail(by imdbId: String) {
        state.value = .loading
        service.getFilmDetail(by: imdbId) { [weak self] in
            guard let strongSelf = self else { return }
            switch $0{
            case .success(let data):
                if data.response == "True"{
                    print(data)
                    strongSelf.details.value = data
                    strongSelf.state.value = .populate
                    strongSelf.updateView.value = true
                } else if data.response == "False"{
                    print(data)
                    strongSelf.showError(message: data.error ?? "No Result")
                    strongSelf.state.value = .error
                }
            case .failure(let error):
                print(error.localizedDescription)
                strongSelf.state.value = .error
            }
        }
    }

    private func showError(message: String) {
        errorState.value = .error(message: message)
    }
}
