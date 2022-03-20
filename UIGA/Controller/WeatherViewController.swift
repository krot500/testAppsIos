//
//  ViewController.swift
//  UIGA
//
//  Created by Admin on 13.07.2021.
//

import UIKit
import WebKit

class WeatherViewController: UIViewController , WKUIDelegate{
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let myURL = URL(string:"http://212.45.3.75/meteo_query/?login=user&pass=user")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            
        }


}

