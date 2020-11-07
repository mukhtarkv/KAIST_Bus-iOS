////
////  DatabaseSetup.swift
////  KAIST_Bus-iOS
////
////  Created by Mukhtar Kussaiynbekov on 11/6/20.
////
//
//import Foundation
//import SQLite
//
//
//
//enum DataAccessError: Error {
//    case Datastore_Connection_Error
//    case Insert_Error
//    case Delete_Error
//    case Search_Error
//    case Nil_In_Data
//}
//
//let path = NSSearchPathForDirectoriesInDomains(
//    .documentDirectory, .userDomainMask, true
//).first!
//
//let db = try! Connection("\(path)/db.sqlite3")
//let weekday = Expression<Bool>("isWeekday")
//let id = Expression<Int>("Indices")
//
//let stmtGetTimeOneTable = try! db.prepare("SELECT leave, arrive FROM (?)->(?) WHERE id = (?) AND isWeekday = (?)")
//
//func createTable(leaveFrom: String, arriveAt: String, timetableWeekdays: [(String, String)], timetableWeekends: [(String, String)]) -> Table {
//    let table = Table("\(leaveFrom)->\(arriveAt)")
//    let leave = Expression<String>("leave")
//    let arrive = Expression<String>("arrive")
//    do {
//        try db.run(table.create { t in
//            t.column(id)
//            t.column(leave)
//            t.column(arrive)
//            t.column(weekday)
//            t.primaryKey(leave, weekday)
//        })
//    } catch {
//        print(error)
//    }
//    for i in 0..<timetableWeekdays.count {
//        let insertWeekday = table.insert(id <- i, leave <- timetableWeekdays[i].0, arrive <- timetableWeekdays[i].1, weekday <- true)
//        do {
//            try db.run(insertWeekday)
//        } catch {
//            print(error)
//        }
//    }
//    for i in 0..<timetableWeekdays.count {
//        let insertWeekend = table.insert(id <- i, leave <- timetableWeekends[i].0, arrive <- timetableWeekends[i].1, weekday <- false)
//        do {
//            try db.run(insertWeekend)
//        } catch {
//            print(error)
//        }
//    }
//    return table
//}
//
//let hwaamMunji = createTable(leaveFrom: K.hwaam, arriveAt: K.munji, timetableWeekdays: Timetable.hwaamToMunjiWeekdays, timetableWeekends: Timetable.hwaamToMunjiWeekends)
//let munjiMain = createTable(leaveFrom: K.munji, arriveAt: K.main, timetableWeekdays: Timetable.munjiToMainWeekdays, timetableWeekends: Timetable.munjiToMainWeekends)
//let mainMunji = createTable(leaveFrom: K.main, arriveAt: K.munji, timetableWeekdays: Timetable.mainToMunjiWeekdays, timetableWeekends: Timetable.mainToMunjiWeekends)
//let munjiHwaam = createTable(leaveFrom: K.munji, arriveAt: K.hwaam, timetableWeekdays: Timetable.munjiToHwaamWeekdays, timetableWeekends: Timetable.munjiToHwaamWeekends)
//
//
//func getTime(atRow: Int, leaveFrom: String, arriveAt: String, isWeekday: Bool) -> (String, String) {
//    var time: (String, String)?
//    if abs(campuses.firstIndex(of: leaveFrom)! - campuses.firstIndex(of: arriveAt)!) != 1 {
//        // TODO: Write SQL query for combining multiple tables
//        return ("", "")
//    }
//    time = try! stmtGetTimeOneTable.scalar(leaveFrom, arriveAt, atRow, isWeekday) as! (String, String)
//    return time!
//}
//
//func getRowCount(leaveFrom: String, arriveAt: String, isWeekday: Bool) -> Int {
//    let count = try! db.scalar("SELECT count (*) FROM \(leaveFrom)->\(arriveAt) WHERE isWeekday = \(isWeekday)") as! Int
//    return count
//}
