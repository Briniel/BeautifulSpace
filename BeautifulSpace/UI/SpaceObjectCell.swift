//
//  SpaceObjectCell.swift
//  BeautifulSpace
//
//  Created by Михаил Иванов on 28.09.2021.
//

import UIKit

class SpaceObjectCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageSpace: UIImageView!

    func configure(with spaceObject: SpaceObject) {
        titleLabel.text = spaceObject.title
        NasaAPI.shared.getSpaceImage(url: spaceObject.hdurl ?? "") { result in
            switch result {
                case .success(let value):
                    self.imageSpace.image = UIImage(data: value as! Data)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
