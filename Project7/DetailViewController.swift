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

		guard let detailItem = detailItem else { return }

		let html = """
		<html>
				<head>
						<meta name="viewport" content="width=device-width, initial-scale=1">
						<style>body { margin: 20px } div { font-size: 120% }</style>
				</head>
				<body>
						<h1>\(detailItem.title)</h1>
						<div>
								<p>\(detailItem.signatureCount) Signatures</p>
								\(detailItem.body)
						</div>
				</body>
		</html>
		"""

		webView.loadHTMLString(html, baseURL: nil)
	}

}
