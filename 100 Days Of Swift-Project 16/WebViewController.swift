//
//  WebViewController.swift
//  100 Days Of Swift-Project 16
//
//  Created by Arda Büyükhatipoğlu on 19.07.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var countryName: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let countryName = countryName else {
            return
        }
        
        if let url = URL(string: "https://en.wikipedia.org/wiki/\(countryName)") {
            loadInfo(url: url)
        } else {
            fatalError("Couldn't convert to url")
        }
    }

    func loadInfo(url: URL) {
        webView.load(URLRequest(url: url))
    }
}
