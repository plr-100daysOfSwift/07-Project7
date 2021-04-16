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

		let urlString: String
		if navigationController?.tabBarItem.tag == 0 {
			// urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
			urlString =  "https://www.hackingwithswift.com/samples/petitions-1.json"
		} else {
			urlString =  "https://www.hackingwithswift.com/samples/petitions-2.json"
		}

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

	func showError() {
		let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed: please check your connection and try again.", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default))
		present(ac, animated: true)
	}

	// MARK: - Table View Data Source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return petitions.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let petition = petitions[indexPath.row]
		cell.textLabel?.text = petition.title
		cell.detailTextLabel?.text = petition.body
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = DetailViewController()
		vc.detailItem = petitions[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
	}

}

