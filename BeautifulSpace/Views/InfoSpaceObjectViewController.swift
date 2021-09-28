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
        imageView.image = UIImage()
        print(imageView.center)
        
        let por = showSpinner(in: imageView)
        
        DispatchQueue.global().async {
            guard let url = URL(string: self.spaceObject.hdurl ?? "") else {
                return
            }
            guard let imageData = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
                print(self.imageView.center)
                por.stopAnimating()
            }
        }
    }

    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        return activityIndicator
    }
}
