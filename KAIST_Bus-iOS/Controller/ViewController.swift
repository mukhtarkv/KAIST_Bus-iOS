//
//  ViewController.swift
//  KAIST_Bus-iOS
//
//  Created by Mukhtar Kussaiynbekov on 11/1/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timetableButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var timetable: [(String, String)] = Timetable.munjiToMainWeekends
    var weekends: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    
    
    @IBAction func timetableButtonPressed(_ sender: UIButton) {
        print("Button pressed")
        if weekends {
            weekends = false
            timetable = Timetable.munjiToMainWeekdays
        } else {
            weekends = true
            timetable = Timetable.munjiToMainWeekends
        }
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

