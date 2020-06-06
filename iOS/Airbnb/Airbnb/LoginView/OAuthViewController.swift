//
//  OAuthViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/05.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit
import WebKit

class OAuthViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        WKWebsiteDataStore.default().httpCookieStore.getAllCookies {
            for cookie in $0 {
                WKWebsiteDataStore.default().httpCookieStore.delete(cookie)
            }
        }
        webView.navigationDelegate = self
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: EndPoint.defaultURL + EndPoint.OAuth)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}

extension OAuthViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        let header = navigationResponse.response as? HTTPURLResponse
        if let token = header?.headers.dictionary["Authorization"] {
            NetworkManager.shared.token = token
            self.dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: .JWTReceived,
                                                object: nil)
            })
        }
        
        decisionHandler(.allow)
    }
}

extension Notification.Name {
    static let JWTReceived = Notification.Name("JWTReceived")
}


