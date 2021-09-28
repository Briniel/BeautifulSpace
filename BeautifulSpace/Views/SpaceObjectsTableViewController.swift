//
//  SpaceObjectsTableViewController.swift
//  BeautifulSpace
//
//  Created by Михаил Иванов on 24.09.2021.
//

import UIKit

class SpaceObjectsTableViewController: UITableViewController {
    var objectsSpace: [SpaceObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAPODs()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objectsSpace.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let objectSpace = objectsSpace[indexPath.row]

        content.text = objectSpace.title

        cell.contentConfiguration = content
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let infoSOVC = segue.destination as? InfoSpaceObjectViewController else { return }
        guard let index = tableView.indexPathForSelectedRow else {
            return
        }

        infoSOVC.spaceObject = objectsSpace[index.row]
    }
}

// MARK: - API connect

extension SpaceObjectsTableViewController {
    func getAPODs() {
        NasaAPI.shared.getSpaceObjects(url: .apod) { result in
            switch result {
                case .success(let result):
                    self.objectsSpace = result as! [SpaceObject]
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
