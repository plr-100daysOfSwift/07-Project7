//
//  DetailViewController.swift
//  Project7
//
//  Created by Paul Richardson on 17/04/2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

	var webView: WKWebView!
	var detailItem: Petition?

	override func loadView() {
		webView = WKWebView()
		view = webView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

}
