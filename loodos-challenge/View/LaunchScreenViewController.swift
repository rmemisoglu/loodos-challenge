//
//  LaunchScreenViewController.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 19.11.2020.
//

import UIKit
import FirebaseRemoteConfig
import Network

class LaunchScreenViewController: BaseViewController {
    
    let loodosLabel : UILabel = {
        let label = UILabel()
        label.frame =  CGRect(x: 0, y: 0, width: 300, height: 50)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private let  isInternet = Dynamic(false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loodosLabel)

        monitor.value.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isInternet.value = true
            } else {
                self.isInternet.value = false
                print("No connection.")
            }
            
            print(path.isExpensive)
        }
        
        monitor.value.start(queue: queue)
        
        isInternet.bind { (val) in
            if val{
                self.getRemoteConfig()
            } else {
                print("No internet")
            }
        }
    }
    func getRemoteConfig(){
        setupRemoteConfigDefaults()
        displayNewValues()
        fetchRemoteConfig()
    }
    
    func setupRemoteConfigDefaults() {
        let defaultValue = ["loodos": ""] as [String:NSObject]
        remoteConfig.setDefaults(defaultValue)
    }
    
    func fetchRemoteConfig(){
        remoteConfig.fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
            guard error == nil else { return }
            print("Got the value from Remote Config!")
            remoteConfig.activate()
            self.displayNewValues()
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                self.animate()
            }
        }
    }
    
    func displayNewValues(){
        let newLabelText = remoteConfig.configValue(forKey: "loodos").stringValue ?? ""
        loodosLabel.text = newLabelText
    }
    
    override func viewDidLayoutSubviews() {
        loodosLabel.center = view.center
    }
    
    func animate(){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.center = self.view.center
        view.backgroundColor = UIColor(named: "BlackColor")
        view.layer.cornerRadius = view.frame.size.height/2
        
        UIView.animate(withDuration: 1, animations: {
            self.loodosLabel.frame = CGRect(x: self.view.frame.size.width-50, y: self.loodosLabel.frame.origin.y, width: 300, height: 50)
            self.loodosLabel.alpha = 0
            
        }) { (complete) in
            if complete{
                UIView.animate(withDuration: 0.5) {
                    self.view.addSubview(view)
                    view.frame = CGRect(origin: self.view.bounds.origin, size: CGSize(width: self.view.frame.height*2, height: self.view.frame.height*2))
                    view.layer.cornerRadius = view.frame.size.height/2
                    
                    let homeViewController = AppCoordinator.homeViewController()
                    let navigationController = UINavigationController(rootViewController: homeViewController)
                    navigationController.modalPresentationStyle = .fullScreen
                    navigationController.modalTransitionStyle = .crossDissolve
                    self.present(navigationController, animated: true, completion: nil)
                 
                }
            }
        }
    }
}
