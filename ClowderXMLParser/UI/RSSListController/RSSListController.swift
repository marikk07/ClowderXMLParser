//
//  RSSListController.swift
//  ClowderXMLParser
//
//  Created by Maryan on 03.03.2020.
//  Copyright © 2020 Marian. All rights reserved.
//

import UIKit
import PKHUD

class RSSListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refresh
    }()
    
    var dataProvider: RSSProviderProtocol!
    
    var dataArray: [RSSItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getRSSList()
    }
    
    private func setupView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.refreshControl = refreshControl
    }
    
    private func getRSSList(_ sender: UIRefreshControl? = nil) {
        if sender == nil { HUD.show(.progress) }
        
        func endRefreshing() {
            DispatchQueue.main.async {
                sender?.endRefreshing()
            }
        }
        
        dataProvider.getRSSList(success: { data in
            HUD.hide()
            self.dataArray = data
            endRefreshing()
            self.tableView.reloadData()
        }, errorHandler: { error in
            HUD.hide()
            endRefreshing()
            debugPrint(error.localizedDescription)
        })
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        if !tableView.isDragging {
            getRSSList(sender)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? RSSWebController, let link = sender as? String {
            controller.link = link
        }
    }
}

extension RSSListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.rssListCell,
                                                    for: indexPath) as? RSSListCell {
            
            cell.setupWith(dataArray[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if refreshControl.isRefreshing {
            getRSSList(refreshControl)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = dataArray[indexPath.row].link
        self.performSegue(withIdentifier: Constants.Segues.showWebView, sender: link)
    }
}
