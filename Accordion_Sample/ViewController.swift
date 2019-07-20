//
//  ViewController.swift
//  Accordion_Sample
//
//  Created by Satoshi Komatsu on 2019/07/20.
//  Copyright © 2019 Satoshi Komatsu. All rights reserved.
//

import UIKit

struct course {
    var isShown: Bool
    var courseName: String
    var mentorLists: [String]
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
    
    lazy var courseArray = [course(isShown: true, courseName: headerArray[0], mentorLists: yamanoteArray),
                            course(isShown: false, courseName: headerArray[1], mentorLists: toyokoArray),
                            course(isShown: false, courseName: headerArray[2], mentorLists: dentoArray),
                            course(isShown: false, courseName: headerArray[3], mentorLists: jobanArray)]
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if courseArray[section].isShown {
            return courseArray[section].mentorLists.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = courseArray[indexPath.section].mentorLists[indexPath.row]
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return courseArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return courseArray[section].courseName
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
        if courseArray[section].isShown {
            courseArray[section].isShown = false
        } else {
           courseArray[section].isShown = true
        }
        
        tableView.beginUpdates()
        tableView.reloadSections([section], with: .automatic)
        tableView.endUpdates()
    }
}
