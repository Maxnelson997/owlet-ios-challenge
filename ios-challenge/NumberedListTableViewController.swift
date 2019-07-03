//
//  NumberedListTableViewController.swift
//  ios-challenge
//
//  Created by Scott Marchant on 4/16/19.
//  Copyright © 2019 Owlet Baby Care Inc. All rights reserved.
//

import UIKit

class NumberedListTableViewController: UITableViewController {
    
    private var listOfNumbers: [Int] = []
    
    private let serialQueue = DispatchQueue(label: "io.async.maxcodes",
                                    qos: .userInteractive,
                                    attributes: .concurrent)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "numberedListedControllerCellID")
        /** If this tb were setup programmatically I would not use a delay for fetchData, instead I would fetch the data immediately and then set dataSource = self after 5 seconds. */
        perform(#selector(fetchData), with: nil, afterDelay: 1)
        perform(#selector(reloadListOnMainThread), with: nil, afterDelay: 5)
    }
    
    // MARK: - private methods
    /**
             reloadListOnMainThread - Call this function to reload the tableView on the main thread
           */
    @objc private func reloadListOnMainThread() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - apiService (If this weren't a code example, I would store this code within a well built, clean API layer)
    /**
             fetchData - Call fetchData to simulate a network request. This code will fetch data without disrubting the user interface.
             Notice, the quality of service is .userInteractive.
     
              .userInteractive prevents the UI from being blocked. However, this QOS is CPU extensive.  
     
             If I were to explain this to a fellow employee I would first tell them to google (Grand Central Dispatch Swift 5) and to CMD click DispatchQueue in Xcode for deets.
             I would then discuss with them how it works if he or she were still confused.
         */
    @objc private func fetchData() {
        DispatchQueue.global(qos: .userInteractive).async {
            [weak self] in
            for number in 1...100 {
                self?.listOfNumbers.append(number)
            }
        }
    }
    
}

// MARK: - Table view data source
/** If tableView protocol methods become too verbose I store them in separate files.
 For example: NumberedListTableViewController+tableViewDelegate.swift and so on.
 */
extension NumberedListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfNumbers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "numberedListedControllerCellID", for: indexPath)
        let listItem = listOfNumbers[indexPath.row]
        cell.textLabel?.text = String(listItem)
        return cell
    }
}

