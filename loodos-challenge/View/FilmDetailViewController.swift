//
//  FilmDetailViewController.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 22.11.2020.
//

import UIKit

class FilmDetailViewController: BaseTableViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var writterLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var awardsLabel: UILabel!
    @IBOutlet weak var seasonsLabel: UILabel!
    
    var viewModel: FilmDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    private func setupViewModel() {
        //for listen states
        viewModel.state.bind { [unowned self] in
            self.stateAnimate($0)
        }
        viewModel.details.bind { [unowned self] in
            guard let details = $0 else { return }
            self.handleResult(with: details)
        }
        viewModel.getFilmDetail(by: viewModel.imdbId)
    }
    
    deinit {
        viewModel.state.unbind()
        viewModel.errorState.unbind()
        viewModel.details.unbind()
    }
    
    func handleResult(with details: MovieResponse){
        if details.poster == Constants.Default.na{
            posterImageView.image = #imageLiteral(resourceName: "default-movie")
        } else {
            posterImageView.loadAndCacheImage(url: details.poster)
        }
        titleLabel.text = details.title?.uppercased()
        yearLabel.text = details.released
        typeLabel.text = details.type
        genreLabel.text = details.genre
        ratingLabel.text = "\(details.imdbRating ?? Constants.Default.na) in \(details.imdbVotes ?? Constants.Default.na) votes"
        plotLabel.text = details.plot
        actorsLabel.text = details.actors
        writterLabel.text = details.writer
        directorLabel.text = details.director
        awardsLabel.text = details.awards
        seasonsLabel.text = details.totalSeasons
    }
    
    private func stateAnimate(_ state: TableViewState) {
        switch state {
        case .loading:
            showLoadingView()
        case .populate:
            removeLoadingView()
            tableView.reloadData()
        case .empty:
            removeLoadingView()
        case .error:
            removeLoadingView()
        }
    }
}
