//
//  LoginViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/05.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func modalWebView(_ sender: Any) {
        guard let oauthViewController = storyboard?.instantiateViewController(withIdentifier: "OAuthViewController") as? OAuthViewController else {return}
        present(oauthViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setObserver()
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(tokenReceived),
                                               name: .JWTReceived,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func tokenReceived() {
        guard let tabbarController = storyboard?.instantiateViewController(withIdentifier: "TabbarController") as? UITabBarController else {return}
        tabbarController.modalPresentationStyle = .fullScreen
        present(tabbarController, animated: true)
    }
}
