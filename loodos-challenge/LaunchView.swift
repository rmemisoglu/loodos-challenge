//
//  LaunchView.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 19.11.2020.
//

import UIKit
class LaunchView: UIView{
    //initWithFrame to init view from code
      override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
      }
      
      //initWithCode to init view from xib or storyboard
      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
      }
      
      //common func to init our view
      private func setupView() {
        backgroundColor = .red
      }
}
