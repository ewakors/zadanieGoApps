//
//  ItemViewController.swift
//  projekt
//
//  Created by Ewa Korszaczuk on 05.10.2017.
//  Copyright © 2017 Ewa Korszaczuk. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var items = [Item]()
    var refresher: UIRefreshControl!
    var itemDetailsVC: ItemDetailsViewController?
    var currentItem: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(ItemViewController.displayItems), for: UIControlEvents.valueChanged)
        tableView.addSubview(refresher)
        
        tableView.dataSource = self as UITableViewDataSource
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 10.0
        displayItems(page: 0,count: 8)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Item.itemShowDetailsSeguage {
            if let cell = sender as? UITableViewCell {
                if let ip = tableView.indexPath(for: cell) {
                    itemDetailsVC = segue.destination as? ItemDetailsViewController
                    itemDetailsVC?.currentItem = items[ip.row]
                    itemDetailsVC?.title = itemDetailsVC?.currentItem?.getTitle()
                    
                    itemDetailsVC?.itemTitleString = itemDetailsVC?.currentItem?.getTitle()
                    itemDetailsVC?.itemSubtitleString = itemDetailsVC?.currentItem?.getSubtitle()
                    itemDetailsVC?.itemImageURL = itemDetailsVC?.currentItem?.getThumb()
                    itemDetailsVC?.titleColor = itemDetailsVC?.currentItem?.backgroundColor()
                }
            }
        }
    }
    
    func displayItems(page: Int, count: Int) {
        
        let request = Router.getItems(page: page, count: count)
        
        API.sharedInstance.sendRequest(request: request) { (json, erorr) in
            if erorr == false {
                if let json = json {
                    self.items = Item.arrayFromJSON(json: json)
                    self.tableView?.reloadData()
                    self.refresher.endRefreshing()
                }
            }
        }
    }
}

extension ItemViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Item.identifier , for: indexPath) as! ItemCell
        
        cell.setItem(item: items[indexPath.row])
        cell.itemSubtitleLabel.numberOfLines = 0
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}

extension ItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        cell.backgroundColor = items[indexPath.row].backgroundColor()
    }
}
