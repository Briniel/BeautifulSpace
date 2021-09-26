//
//  InfoSpaceObjectViewController.swift
//  BeautifulSpace
//
//  Created by Михаил Иванов on 24.09.2021.
//

import UIKit

class InfoSpaceObjectViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var explanationLabel: UILabel!
    
    var spaceObject: SpaceObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = spaceObject.date
        explanationLabel.text = spaceObject.explanation
        
        DispatchQueue.global().async {
            guard let url = URL(string: self.spaceObject.hdurl ?? "") else {
                return
            }
            guard let imageData = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
    

}
