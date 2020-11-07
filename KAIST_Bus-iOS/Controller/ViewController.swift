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

    var timetable: [(String, String)] = Timetable.munjiToMainWeekends
    var weekends: Bool = true

    var fromMenuOptions: [String] = campuses
    var toMenuOptions: [String] = [K.hwaam, K.main]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        menuSetUp(menu: fromMenu, placeholder: K.munji, options: fromMenuOptions)
        menuSetUp(menu: toMenu, placeholder: K.main, options: toMenuOptions)
        
        fromMenu.didSelect{(selectedText, index, id) in
            self.toMenu.optionArray = Array(campuses[..<index] + campuses[(index+1)...])
            self.tableView.reloadData()
        }
        
        toMenu.didSelect{(selectedText, index, id) in
            self.toMenu.optionArray = self.slice(array: campuses, index: index)
            self.tableView.reloadData()
        }
    }
    
    func slice(array: [String], index: Int) -> [String] {
        return Array(array[..<index] + array[(index+1)...])
    }
    
    func menuSetUp(menu: DropDown!, placeholder: String, options: [String]) {
        menu.optionArray = campuses
        menu.isSearchEnable = false
        menu.placeholder = placeholder
        menu.text = placeholder
        menu.selectedIndex = campuses.firstIndex(of: placeholder)
    }
    
    
    @IBAction func swapButtonPressed(_ sender: UIButton) {
        swap(&fromMenu.selectedIndex, &toMenu.selectedIndex)
        fromMenu.text = campuses[fromMenu.selectedIndex!]
        toMenu.text = campuses[toMenu.selectedIndex!]
        tableView.reloadData()
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
