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
        print("Координаты картинки: \(imageView.center.y)")
        print("Координаты view: \(view.center)")
        
        
        let spinner = showSpinner(in: imageView)
        showImage(spinner: spinner)
        print("Координаты картинки: \(imageView.center)")
    }

    private func showSpinner(in view: UIImageView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        return activityIndicator
    }
    
    private func showImage(spinner: UIActivityIndicatorView) {
        NasaAPI.shared.getSpaceImage(url: spaceObject.hdurl ?? "") { result in
            switch result {
                case .success(let value):
                    self.imageView.image = UIImage(data: value as! Data)
                    spinner.stopAnimating()
                case .failure(let error):
                    print(error)
            }
        }
    }
}
