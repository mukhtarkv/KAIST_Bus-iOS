//
//  ViewController.swift
//  KAIST_Bus-iOS
//
//  Created by Mukhtar Kussaiynbekov on 11/1/20.
//

import UIKit
import SwiftyMenu

class ViewController: UIViewController {
    
    @IBOutlet weak var fromMenu: SwiftyMenu!
    @IBOutlet weak var toMenu: SwiftyMenu!
    @IBOutlet weak var swapButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var timetable: [(String, String)] = Timetable.munjiToMainWeekends
    var weekends: Bool = true
    
    private let items: [SwiftyMenuDisplayable] = ["Munji", "Option 2", "Option 3", "Option 4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        fromMenu.delegate = self
//        toMenu.delegate = self
        fromMenu.items = items
        fromMenu.placeHolderText = K.fromMenuPlaceHolder
        fromMenu.placeHolderColor = fromMenu.itemTextColor
        fromMenu.selectedIndex = 0
        // Support different callbacks for different events
        
        fromMenu.didExpand = {
            print("SwiftyMenu Expanded!")
        }

        fromMenu.didCollapse = {
            print("SwiftyMeny Collapsed")
        }

        fromMenu.didSelectItem = { menu, item, index in
            print("\(item) at index: \(index)")
        }
        
//        toMenu.items = items
//
//        // Support different callbacks for different events
//        toMenu.didExpand = {
//            print("SwiftyMenu Expanded!")
//        }
//
//        toMenu.didCollapse = {
//            print("SwiftyMeny Collapsed")
//        }
//
//        toMenu.didSelectItem = { menu, item, index in
//            print("\(item) at index: \(index)")
//        }
        
//        // Change option's row height (default 35)
//        fromMenu.rowHeight = 1
//
//        // Change option's drop down menu height
//        // default is 0, which make drop down height = number of options * rowHeight
//        fromMenu.listHeight = 150
//
//        // Change drop down menu border width
//        fromMenu.borderWidth = 1.0
//
//        // Change drop down menu scroll behavior
//        fromMenu.scrollingEnabled = false
//
//        // Change drop down menu default colors
//        fromMenu.borderColor = .black
//        fromMenu.itemTextColor = .red
//        fromMenu.placeHolderColor = .blue
//        fromMenu.menuHeaderBackgroundColor = .lightGray
//        fromMenu.rowBackgroundColor = .orange
//        fromMenu.separatorColor = .white
//
//        // Change drop down menu default expand and collapse animation
//        fromMenu.expandingAnimationStyle = .spring(level: .low)
//        fromMenu.expandingDuration = 0.5
//        fromMenu.collapsingAnimationStyle = .linear
//        fromMenu.collapsingDuration = 0.5
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

extension ViewController: SwiftyMenuDelegate {
    // Get selected option from SwiftyMenu
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didSelectItem item: SwiftyMenuDisplayable, atIndex index: Int) {
        print("Selected item: \(item), at index: \(index)")
    }
    
    // SwiftyMenu drop down menu will expand
    func swiftyMenu(willExpand swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu willExpand.")
    }

    // SwiftyMenu drop down menu did expand
    func swiftyMenu(didExpand swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu didExpand.")
    }

    // SwiftyMenu drop down menu will collapse
    func swiftyMenu(willCollapse swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu willCollapse.")
    }

    // SwiftyMenu drop down menu did collapse
    func swiftyMenu(didCollapse swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu didCollapse.")
    }
}
