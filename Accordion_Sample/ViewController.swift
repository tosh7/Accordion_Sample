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
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    private let headerArray: [String] = ["山手線", "東横線", "田園都市線", "常磐線"]
    private let yamanoteArray: [String] = ["渋谷", "新宿", "池袋"]
    private let toyokoArray: [String] = ["自由ヶ丘", "日吉"]
    private let dentoArray: [String] = ["溝の口", "二子玉川"]
    private let jobanArray: [String] = ["上野"]

    private lazy var courseArray = [
        rail(isShown: true, railName: self.headerArray[0], stationArray: self.yamanoteArray),
        rail(isShown: false, railName: self.headerArray[1], stationArray: self.toyokoArray),
        rail(isShown: false, railName: self.headerArray[2], stationArray: self.dentoArray),
        rail(isShown: false, railName: self.headerArray[3], stationArray: self.jobanArray)
    ]
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        return courseArray[section].isShown ? courseArray[section].stationArray.count : 0
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
