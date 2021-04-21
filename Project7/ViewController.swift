//
//  ViewController.swift
//  Project7
//
//  Created by Paul Richardson on 16/04/2021.
//

import UIKit

class ViewController: UITableViewController {

	var petitions = [Petition]()
	var filteredPetitions = [Petition]()
	var urlString: String?

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Whitehouse Petitions"
		// TODO: Display the number of petitions currently showing

		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))

		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(provideInput))

		if navigationController?.tabBarItem.tag == 0 {
			// urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
			urlString =  "https://www.hackingwithswift.com/samples/petitions-1.json"
		} else {
			urlString =  "https://www.hackingwithswift.com/samples/petitions-2.json"
		}

		performSelector(inBackground: #selector(fetchJSON), with: nil)

	}

	func parse(json: Data) {
		let decoder = JSONDecoder()

		if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
			petitions = jsonPetitions.results
			filteredPetitions = petitions
			DispatchQueue.main.async { [weak self] in
				self?.tableView.reloadData()
			}
		}

	}

	@objc func showError() {
			let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed: please check your connection and try again.", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .default))
			present(ac, animated: true)
	}

	@objc func showCredits() {
		guard let urlString = urlString, let host = URL(string: urlString)?.host else { return }

		let source = "Source: \(host)"
		let message: String
		
		if host.contains("hackingwithswift") {
			message = "This is a cached copy.\n" + source
		} else {
			message = source
		}

		let ac = UIAlertController(title: "Credits", message: message, preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default))
		present(ac, animated: true)
	}

	@objc func provideInput() {

		let ac = UIAlertController(title: "Filter Petitions by Title", message: "Enter some text", preferredStyle: .alert)
		ac.addTextField()
		ac.addAction(UIAlertAction(title: "OK", style: .default) { action in
			if let textToFilter = ac.textFields?[0].text, !textToFilter.isEmpty {
				self.filterPetitions(text: textToFilter)
			}
		})
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		present(ac, animated: true)

	}

	@objc func filterPetitions(text: String) {
		let searchText = text.lowercased()
		var results = [Petition]()

		for petition in petitions {
			if petition.title.lowercased().contains(searchText) {
				results.append(petition)
			}
		}

		if !results.isEmpty {
			filteredPetitions = results
		} else {
			filteredPetitions = petitions
			// TODO: Nothing found - inform the user
		}
		tableView.reloadData()
	}

	@objc	fileprivate func fetchJSON() {

		if let urlString = urlString, let url = URL(string: urlString) {
			if let data = try? Data(contentsOf: url) {
				parse(json: data)
				return
			}
		}

		performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)

	}



	// MARK: - Table View Data Source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredPetitions.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let petition = filteredPetitions[indexPath.row]
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

