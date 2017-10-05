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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self as! UITableViewDataSource
        //itemTableView.dataSource = self as! UITableViewDataSource
        displayItems()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayItems() {
        let request = Router.getItems()
        
        API.sharedInstance.sendRequest(request: request) { (json, erorr) in
            if erorr == false {
                if let json = json {
                 
                    self.items = Item.arrayFromJSON(json: json)

                    DispatchQueue.main.async {
                        self.tableView?.reloadData()
                    } 
                }
            }
        }
    }
}

extension ItemViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Item.identifier , for: indexPath) as! ItemCell
        
        cell.setItem(item: items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
