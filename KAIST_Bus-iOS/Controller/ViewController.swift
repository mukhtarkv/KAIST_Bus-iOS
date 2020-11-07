//
//  ViewController.swift
//  KAIST_Bus-iOS
//
//  Created by Mukhtar Kussaiynbekov on 11/1/20.
//

import UIKit
import iOSDropDown

class ViewController: UIViewController{
    @IBOutlet weak var fromMenu: DropDown!
    @IBOutlet weak var toMenu: DropDown!
    @IBOutlet weak var swapButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var weekdayBoolMenu: DropDown!
    var isWeekday: Bool = true
    var timetable: [(String, String)] = Timetable.munjiToMainWeekdays
    var weekends: Bool = true
    let campuses: [String] = [K.hwaam, K.munji, K.main]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        menuSetUp(menu: fromMenu, placeholder: K.munji, options: campuses)
        menuSetUp(menu: toMenu, placeholder: K.main, options: [K.hwaam, K.main])
        toMenu.optionArray = slice(array: campuses, index: campuses.firstIndex(of: fromMenu.text!)!)
        fromMenu.optionArray = slice(array: campuses, index: campuses.firstIndex(of: toMenu.text!)!)
        toMenu.selectedIndex = toMenu.optionArray.firstIndex(of: toMenu.text!)
        fromMenu.selectedIndex = fromMenu.optionArray.firstIndex(of: fromMenu.text!)
        
        weekdayBoolMenu.optionArray = [K.weekday, K.weekend]
        weekdayBoolMenu.text = K.weekday
        weekdayBoolMenu.selectedIndex = weekdayBoolMenu.optionArray.firstIndex(of: K.weekday)
        weekdayBoolMenu.isSearchEnable = false
        
        fromMenu.didSelect{(selectedText, index, id) in
            self.toMenu.optionArray = self.slice(array: self.campuses, index: self.campuses.firstIndex(of: selectedText)!)
            self.toMenu.selectedIndex = self.toMenu.optionArray.firstIndex(of: self.toMenu.text!)
            self.fromMenu.text = selectedText
            self.setUpTimetable()
            self.tableView.reloadData()
        }
        
        toMenu.didSelect{(selectedText, index, id) in
            self.fromMenu.optionArray = self.slice(array: self.campuses, index: self.campuses.firstIndex(of: selectedText)!)
            self.fromMenu.selectedIndex = self.fromMenu.optionArray.firstIndex(of: self.fromMenu.text!)
            self.toMenu.text = selectedText
            self.setUpTimetable()
            self.tableView.reloadData()
        }
        
        weekdayBoolMenu.didSelect{(selectedText, index, id) in
            if selectedText == K.weekday {
                self.isWeekday = true
            } else {
                self.isWeekday = false
            }
            self.weekdayBoolMenu.text = selectedText
            self.weekdayBoolMenu.selectedIndex = index
            self.setUpTimetable()
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
        swap(&fromMenu.optionArray, &toMenu.optionArray)
        swap(&fromMenu.selectedIndex, &toMenu.selectedIndex)
        fromMenu.text = fromMenu.optionArray[fromMenu.selectedIndex!]
        toMenu.text = toMenu.optionArray[toMenu.selectedIndex!]
        setUpTimetable()
        tableView.reloadData()
    }
    
    func setUpTimetable() {
        if fromMenu.text == K.main && toMenu.text == K.munji {
            if isWeekday {
                timetable = Timetable.mainToMunjiWeekdays
            } else {
                timetable = Timetable.mainToMunjiWeekends
            }
        }
        else if fromMenu.text == K.munji && toMenu.text == K.main {
            if isWeekday {
                timetable = Timetable.munjiToMainWeekdays
            } else {
                timetable = Timetable.munjiToMainWeekends
            }
        }
        else if fromMenu.text == K.hwaam && toMenu.text == K.munji {
            if isWeekday {
                timetable = Timetable.hwaamToMunjiWeekdays
            } else {
                timetable = Timetable.hwaamToMunjiWeekends
            }
        }
        else if fromMenu.text == K.munji && toMenu.text == K.hwaam {
            if isWeekday {
                timetable = Timetable.munjiToHwaamWeekdays
            } else {
                timetable = Timetable.munjiToHwaamWeekends
            }
        }
        else if fromMenu.text == K.main &&  toMenu.text == K.hwaam {
            if isWeekday {
                timetable = Timetable.mainToHwaamWeekdays
            } else {
                timetable = Timetable.mainToHwaamWeekends
            }
        }
        else if fromMenu.text == K.hwaam && toMenu.text == K.main {
            if isWeekday {
                timetable = Timetable.hwaamToMainWeekdays
            } else {
                timetable = Timetable.hwaamToMainWeekends
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timetable.count
//        return getRowCount(leaveFrom: fromMenu.text!, arriveAt: toMenu.text!, isWeekday: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! TimetableCell
//        let time: (String, String) = getTime(atRow: indexPath.row, leaveFrom: fromMenu.text!, arriveAt: toMenu.text!, isWeekday: true)
        cell.departureTimeLabel.text = timetable[indexPath.row].0
        cell.arrivalTimeLabel.text = timetable[indexPath.row].1
        return cell
    }
}
