//
//  RSSWebController.swift
//  ClowderXMLParser
//
//  Created by Maryan on 03.03.2020.
//  Copyright © 2020 Marian. All rights reserved.
//

import UIKit
import WebKit

class RSSWebController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var link: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let link = link, let url = URL(string: link) {
            let urlRequest = URLRequest(url: url)
            self.webView.load(urlRequest)
        }
    }
}
