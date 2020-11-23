//
//  FilmDetailViewController.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 22.11.2020.
//

import UIKit
import Firebase

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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupViewModel() {
        //for listen states
        viewModel.state.bind { [unowned self] in
            self.stateAnimate($0)
        }
        
        viewModel.details.bind { [unowned self] in
            guard let details = $0 else { return }
            self.logData(with: details)
        }
        
        viewModel.updateView.bind{ [unowned self] in
            if $0{
                guard let details = viewModel.details.value else {return}
                
                if details.poster == Constants.Default.na{
                    self.posterImageView.image = #imageLiteral(resourceName: "default-movie")
                } else {
                    self.posterImageView.loadAndCacheImage(url: details.poster)
                }
                self.titleLabel.text = details.title.uppercased()
                self.yearLabel.text = details.released
                self.typeLabel.text = details.type
                self.genreLabel.text = details.genre
                self.ratingLabel.text = "\(details.imdbRating ?? Constants.Default.na) in \(details.imdbVotes ?? Constants.Default.na) votes"
                self.plotLabel.text = details.plot
                self.actorsLabel.text = details.actors
                self.writterLabel.text = details.writer
                self.directorLabel.text = details.director
                self.awardsLabel.text = details.awards
                self.seasonsLabel.text = details.totalSeasons ?? Constants.Default.na
            }
        }
        viewModel.getFilmDetail(by: viewModel.imdbId)
    }
    
    deinit {
        viewModel.state.unbind()
        viewModel.errorState.unbind()
        viewModel.details.unbind()
    }
    
    func logData(with details: MovieResponse){
        guard let log = details.dictionary else { return }
        Analytics.logEvent("movie_detail", parameters: log)
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
