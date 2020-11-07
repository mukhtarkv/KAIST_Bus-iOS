//
//  ViewController.swift
//  KAIST_Bus-iOS
//
//  Created by Mukhtar Kussaiynbekov on 11/1/20.
//

import UIKit
import iOSDropDown

class ViewController: UIViewController {
    
    @IBOutlet weak var fromMenu: DropDown!
    @IBOutlet weak var toMenu: DropDown!
    @IBOutlet weak var swapButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let campuses: [String] = [K.hwaam, K.munji, K.main]
    var timetable: [(String, String)] = Timetable.munjiToMainWeekends
    var weekends: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        menuSetUp(menu: fromMenu, placeholder: K.munji)
        menuSetUp(menu: toMenu, placeholder: K.main)
    }
    
    func menuSetUp(menu: DropDown!, placeholder: String) {
        menu.optionArray = campuses
        menu.isSearchEnable = false
        menu.selectedIndex = campuses.firstIndex(of: placeholder)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timetable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! TimetableCell
        cell.departureTimeLabel.text = timetable[indexPath.row].0
        cell.arrivalTimeLabel.text = timetable[indexPath.row].1
        return cell
    }
}
