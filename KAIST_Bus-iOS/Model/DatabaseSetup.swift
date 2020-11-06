//
//  DatabaseSetup.swift
//  KAIST_Bus-iOS
//
//  Created by Mukhtar Kussaiynbekov on 11/6/20.
//

import Foundation
import SQLite

enum DataAccessError: Error {
    case Datastore_Connection_Error
    case Insert_Error
    case Delete_Error
    case Search_Error
    case Nil_In_Data
}

let path = NSSearchPathForDirectoriesInDomains(
    .documentDirectory, .userDomainMask, true
).first!

let db = try! Connection("\(path)/db.sqlite3")
let weekday = Expression<Bool>("isWeekday")


func createTable(leaveFrom: String, arriveAt: String) -> Table {
    let table = Table("\(leaveFrom)->\(arriveAt)")
    let leave = Expression<String>("Leave \(leaveFrom)")
    let arrive = Expression<String>("Arrive \(arriveAt)")
    do {
        try db.run(table.create { t in
            t.column(leave)
            t.column(arrive)
            t.column(weekday)
            t.primaryKey(leave, weekday)
        })
    } catch {
        print(error)
    }
    return table
}

func addTimetable(table: Table, leaveFrom: String, arriveAt: String, isWeekday: Bool, timetable: [(String, String)]) {
    for time in timetable {
        let leave = Expression<String>("Leave \(leaveFrom)")
        let arrive = Expression<String>("Arrive \(arriveAt)")
        
        let insert = table.insert(leave <- time.0, arrive <- time.1, weekday <- isWeekday)
        do {
            let rowid = try db.run(insert)
        } catch {
            print(error)
        }
    }
}
