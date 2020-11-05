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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        fromMenu.optionArray = ["Munji", "Hwaam", "Main"]
        toMenu.optionArray = ["Munji", "Hwaam", "Main"]
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
