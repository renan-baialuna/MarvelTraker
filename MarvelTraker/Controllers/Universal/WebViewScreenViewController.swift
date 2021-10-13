//
//  WebViewScreenViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 30/09/21.
//

import UIKit
import WebKit

class WebViewScreenViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var urlString: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.navigationDelegate = self
        let url = URL(string: "www.google.com")
        let request  = NSURLRequest(url: url!)
        webView.load(request as URLRequest)
    }
    
}
