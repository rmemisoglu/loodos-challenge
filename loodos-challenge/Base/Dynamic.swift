//
//  Dynamic.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 20.11.2020.
//

import Foundation
class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    func unbind() {
        listener = nil
    }
    
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
        
    }
    
    init(_ v: T) {
        value = v
    }
    
}
