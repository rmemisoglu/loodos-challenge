//
//  ViewController.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 19.11.2020.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    let searchController = UISearchController(searchResultsController: nil)

    var viewModel: HomeViewModel!
    var backgroundLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupView()
        setupTableView()
        setupSearchBar()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        navigationItem.title = "SEARCH FILMS"
        //navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViewModel() {
        viewModel = HomeViewModel(service: NetworkService.shared)
        //for listen states
        viewModel.state.bind { [unowned self] in
            self.stateAnimate($0)
        }
        
        viewModel.errorState.bind { [unowned self] in
            self.handleAlert($0)
        }
        
        viewModel.routeFilmDetail.bind { [unowned self] in
            guard let filmDetailViewModel = $0 else { return }
            let vc = AppCoordinator.filmDetailViewController()
            vc.viewModel = filmDetailViewModel
            self.present(vc, animated: true, completion: nil)
            //navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        backgroundLabel.frame = tableView.frame
        backgroundLabel.text = "You can search movies.."
        backgroundLabel.textAlignment = .center
        backgroundLabel.textColor = .lightGray
        backgroundLabel.numberOfLines = 0
        backgroundLabel.font = .systemFont(ofSize: 32, weight: .light)
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if searchText.count > 2{
            viewModel.getFilms(with: searchText)
        }
    }
    
    private func setupSearchBar(){
        
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies..."
        navigationItem.titleView = searchController.searchBar
        //definesPresentationContext = true
        searchController.searchBar.delegate = self
        
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.backgroundColor = UIColor(named:"BlackColor")
        } else {
            // Fallback on earlier versions
        }
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.searchTextField.tintColor = .white
    }
    
    deinit {
        viewModel.state.unbind()
        viewModel.errorState.unbind()
        viewModel.routeFilmDetail.unbind()
    }
    
    private func stateAnimate(_ state: TableViewState) {
        switch state {
        case .loading:
            showLoadingView()
        case .populate:
            removeLoadingView()
            tableView.reloadData()
            searchController.isActive = false
        case .empty:
            removeLoadingView()
            searchController.isActive = false
        case .error:
            removeLoadingView()
            searchController.isActive = false
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.results.count == 0 {
            tableView.backgroundView = backgroundLabel
        } else {
            tableView.backgroundView = nil
        }
        return viewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmsTableViewCell", for: indexPath) as! FilmsTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        let item: MovieResponse
        
        item = viewModel.results[indexPath.row]
        
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let imdbId = viewModel.results[indexPath.row].imdbID else { return }
        
        viewModel.routeFilmDetail.value = FilmDetailViewModel(service: NetworkService.shared, imdbId: imdbId)
    }
}

extension HomeViewController: UISearchControllerDelegate,UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, searchText != "" {
            filterContentForSearchText(searchText)
        } else {
            viewModel.state.value = .populate
        }
    }
}
