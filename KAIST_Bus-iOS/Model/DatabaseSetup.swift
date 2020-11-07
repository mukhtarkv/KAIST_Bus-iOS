//
//  DatabaseSetup.swift
//  KAIST_Bus-iOS
//
//  Created by Mukhtar Kussaiynbekov on 11/6/20.
//

import Foundation
import SQLite

let campuses: [String] = [K.hwaam, K.munji, K.main]

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
let id = Expression<Int>("Indices")

let stmtGetTimeOneTable = try! db.prepare("SELECT leave, arrive FROM (?)->(?) WHERE id = (?) AND isWeekday = (?)")

func createTable(leaveFrom: String, arriveAt: String) -> Table {
    let table = Table("\(leaveFrom)->\(arriveAt)")
    let leave = Expression<String>("leave")
    let arrive = Expression<String>("arrive")
    do {
        try db.run(table.create { t in
            t.column(id)
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

let hwaamMunji = createTable(leaveFrom: K.hwaam, arriveAt: K.munji)
let munjiMain = createTable(leaveFrom: K.munji, arriveAt: K.main)
let mainMunji = createTable(leaveFrom: K.main, arriveAt: K.munji)
let munjiHwaam = createTable(leaveFrom: K.munji, arriveAt: K.hwaam)

func addTimetable(table: Table, leaveFrom: String, arriveAt: String, isWeekday: Bool, timetable: [(String, String)]) {
    for i in 0..<timetable.count {
        let leave = Expression<String>("Leave \(leaveFrom)")
        let arrive = Expression<String>("Arrive \(arriveAt)")
        
        let insert = table.insert(id <- i, leave <- timetable[i].0, arrive <- timetable[i].1, weekday <- isWeekday)
        do {
            let rowid = try db.run(insert)
        } catch {
            print(error)
        }
    }
}

func getTime(atRow: Int, leaveFrom: String, arriveAt: String, isWeekday: Bool) -> (String, String) {
    var time: (String, String)?
    if abs(campuses.firstIndex(of: leaveFrom)! - campuses.firstIndex(of: arriveAt)!) != 1 {
        // TODO: Write SQL query for combining multiple tables
        return ("", "")
    }
    time = try! stmtGetTimeOneTable.scalar(leaveFrom, arriveAt, atRow, isWeekday) as! (String, String)
    return time!
}
