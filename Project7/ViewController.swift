//
//  ViewController.swift
//  Project7
//
//  Created by Paul Richardson on 16/04/2021.
//

import UIKit

class ViewController: UITableViewController {

	var petitions = [Petition]()

	override func viewDidLoad() {
		super.viewDidLoad()

		let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"

		// TODO:  by downloading data from the internet in viewDidLoad() our app will lock up until all the data has been transferred.
		if let url = URL(string: urlString) {
			if let data = try? Data(contentsOf: url) {
				parse(json: data)
			}
		}
	}

	func parse(json: Data) {
		let decoder = JSONDecoder()

		if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
			petitions = jsonPetitions.results
			tableView.reloadData()
		}

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

