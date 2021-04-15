//
//  ViewController.swift
//  Project7
//
//  Created by Paul Richardson on 16/04/2021.
//

import UIKit

class ViewController: UITableViewController {

	var petitions = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	// MARK: - Table View Data Source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return petitions.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = "Title goes here"
		cell.detailTextLabel?.text = "Subtitle goes here"
		return cell
	}
	
}

