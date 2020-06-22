//
//  ViewController.swift
//  Accordion_Sample
//
//  Created by Satoshi Komatsu on 2019/07/20.
//  Copyright © 2019 Satoshi Komatsu. All rights reserved.
//

import UIKit

struct rail {
    var isShown: Bool
    var railName: String
    var stationArray: [String]
}

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    let headerArray: [String] = ["山手線", "東横線", "田園都市線", "常磐線"]
    let yamanoteArray: [String] = ["渋谷", "新宿", "池袋"]
    let toyokoArray: [String] = ["自由ヶ丘", "日吉"]
    let dentoArray: [String] = ["溝の口", "二子玉川"]
    let jobanArray: [String] = ["上野"]
    
    lazy var courseArray = [rail(isShown: true, railName: headerArray[0], stationArray: yamanoteArray),
                            rail(isShown: false, railName: headerArray[1], stationArray: toyokoArray),
                            rail(isShown: false, railName: headerArray[2], stationArray: dentoArray),
                            rail(isShown: false, railName: headerArray[3], stationArray: jobanArray)]
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if courseArray[section].isShown {
            return courseArray[section].stationArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = courseArray[indexPath.section].stationArray[indexPath.row]
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return courseArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return courseArray[section].railName
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(headertapped(sender:)))
        headerView.addGestureRecognizer(gesture)
        headerView.tag = section
        return headerView
    }
    
    @objc func headertapped(sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else {
            return
        }
        courseArray[section].isShown.toggle()
        
        tableView.beginUpdates()
        tableView.reloadSections([section], with: .automatic)
        tableView.endUpdates()
    }
}
