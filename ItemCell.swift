//
//  ItemCell.swift
//  projekt
//
//  Created by Ewa Korszaczuk on 05.10.2017.
//  Copyright © 2017 Ewa Korszaczuk. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var itemSubtitleLabel: UILabel!
    @IBOutlet var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setItem(item: Item) {
        itemTitleLabel.text = item.getTitle()
        itemSubtitleLabel.text = item.getSubtitle()
        
        let itemThumbURL = item.getThumb()
        let thumbUrl = NSURL(string: itemThumbURL)
        
        if itemThumbURL != "" {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: thumbUrl! as URL)
                DispatchQueue.main.async {
                    self.itemImageView.image = UIImage(data: data!)
                }
            }
        } else {
            
        }
        //itemSubtitleLabel.text = item.getSubtitle()
    }
    
}
