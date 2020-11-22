//
//  FilmsTableViewCell.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 20.11.2020.
//

import Foundation
import Foundation
import UIKit

class FilmsTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    // MARK: - Variables
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        // Initialization code
    }
    
    func setupView() {
    }
    
    func configure(with movie: MovieResponse) {
        if movie.poster == Constants.Default.na{
            posterImageView.image = #imageLiteral(resourceName: "default-movie")
        } else {
            posterImageView.loadAndCacheImage(url: movie.poster)
        }
        titleLabel.text = movie.title
        yearLabel.text = movie.year
        typeLabel.text = movie.type?.capitalized
    }
}
