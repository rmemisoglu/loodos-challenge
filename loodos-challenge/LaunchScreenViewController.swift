//
//  LaunchScreenViewController.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 19.11.2020.
//

import UIKit
import FirebaseRemoteConfig
class LaunchScreenViewController: UIViewController {
    let loodosLabel : UILabel = {
        let label = UILabel()
        label.frame =  CGRect(x: 0, y: 0, width: 300, height: 50)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loodosLabel)
        setupRemoteConfigDefaults()
        displayNewValues()
        fetchRemoteConfig()
        // Do any additional setup after loading the view.
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
        
        UIView.animate(withDuration: 1, animations: {
            self.loodosLabel.frame = CGRect(x: self.view.frame.size.width-50, y: self.view.frame.height/2, width: 300, height: 50)
            self.loodosLabel.alpha = 0
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            self.loodosLabel.alpha = 0
        }) { (complete) in
            if complete{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    let v = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
                    v.modalTransitionStyle = .crossDissolve
                    v.modalPresentationStyle = .fullScreen
                    self.present(v, animated: true, completion: nil)
                }
                
            }
        }
        
    }
}
