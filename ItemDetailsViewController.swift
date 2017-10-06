//
//  ItemDetailsViewController.swift
//  projekt
//
//  Created by Ewa Korszaczuk on 05.10.2017.
//  Copyright © 2017 Ewa Korszaczuk. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    @IBOutlet var itemSubtitleLabel: UILabel!
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var thumbImageView: UIImageView!
    
    var itemTitleString: String!
    var itemSubtitleString: String!
    var itemImageURL: String!
    var titleColor: UIColor!
    var currentItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let title = itemTitleString {
            itemTitleLabel.text = title
        }
        
        if let subtitle = itemSubtitleString {
            itemSubtitleLabel.text = subtitle
        }
        
        if let itemThumbURL = itemImageURL {
            let thumbUrl = NSURL(string: itemThumbURL)
            
            if itemThumbURL != "" {
                let data = try? Data(contentsOf: thumbUrl! as URL)
                
                DispatchQueue.main.async {
                    self.thumbImageView.image = UIImage(data: data!)
                }
            } else {
                
            }
        }
        
        if let color = titleColor {
            itemTitleLabel.textColor = color
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
