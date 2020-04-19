//
//  AppDelegate.swift
//  FinalExam_Sherwin_Gonsalves
//
//  Created by Sherwin on 2020-03-30.
//  Copyright © 2020 Sherwin. All rights reserved.
//

import UIKit
import SQLite3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var databaseName : String? = "FinalExam.db"
    var databasePath : String?
    //var users : [User] = []
    var user : [UsersClass] = []


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir = documentPaths[0]
        databasePath = documentsDir.appending("/" + databaseName!)
        checkAndCreateDatabase()
        readDataFromDatabase()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func getUserByName (name : String) -> UsersClass? {
    
        var user : UsersClass? = nil
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath!, &db) == SQLITE_OK {
            
            var findUserStatement : OpaquePointer? = nil
            var findUserStatementString : String = "select Id, Name, Age, Avatar from Users where Name = ?"
            
            if sqlite3_prepare_v2(db, findUserStatementString, -1, &findUserStatement, nil) == SQLITE_OK {
                
                let cName = name as NSString
                
                sqlite3_bind_text(findUserStatement, 1, cName.utf8String, -1, nil)
                
                if sqlite3_step(findUserStatement) == SQLITE_ROW {
                    
                    let id : Int = Int(sqlite3_column_int(findUserStatement, 0))
                    let cName = sqlite3_column_text(findUserStatement, 1)
                    let cAge = Int(sqlite3_column_int(findUserStatement, 2))
                    let cAvatar = sqlite3_column_text(findUserStatement, 3)
                    
                    let name = String(cString: cName!)
                    let avatars = String(cString: cAvatar!)
                    
                    user = UsersClass(Int32(id), name: name, age: Int32(cAge), avatar : avatars)
                    
                } else {
                    print("Cannot find name: \(name)")
                }
                
                sqlite3_finalize(findUserStatement)
            } else {
                print("Could not prepare find user by name statement")
            }
            
            sqlite3_close(db)
        } else {
            print("Could not open database")
        }
        return user
    }
    func updateUserDetails(usersl: UsersClass, Avatar : String, Age : Int) -> Bool {
        var db : OpaquePointer? = nil
        var returnCode : Bool = true
        
        if sqlite3_open(self.databasePath!, &db) == SQLITE_OK {
            
            var updateStatement : OpaquePointer? = nil
            var updateStatementString : String = "update users set Age = ?, Avatar = ? where ID = ?"
            
            if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
                
       
                let avatar = Avatar as NSString
                
                let cage = Age as Int
                
                
                sqlite3_bind_int(updateStatement, 1, Int32(cage))
                sqlite3_bind_text(updateStatement, 2, avatar.utf8String, -1, nil)
                sqlite3_bind_int(updateStatement, 3, Int32(usersl.id))
                
                
                if sqlite3_step(updateStatement) == SQLITE_DONE {
                    print("Updated password of user \(usersl.id) | \(usersl.name)")
                } else {
                    print("Update user password failed")
                    returnCode = false
                }
                
                sqlite3_finalize(updateStatement)
            } else {
                print("Could not prepare update user statement")
                returnCode = false
            }
            
            sqlite3_close(db)
        } else {
            print("Could not open db")
            returnCode = false
        }
        
        return returnCode
    }
    func readDataFromDatabase()
    {
        user.removeAll()
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db)==SQLITE_OK
        {
            print("Successfully Opened database \(self.databasePath)")
            var queryStaement :OpaquePointer? = nil
            var queryStaementString : String = "select * from users"
            if sqlite3_prepare_v2(db, queryStaementString, -1, &queryStaement, nil) == SQLITE_OK
            {
                
                while sqlite3_step(queryStaement) == SQLITE_ROW
                {
                    let Id : Int = Int(sqlite3_column_int(queryStaement, 0))
                    let cname = sqlite3_column_text(queryStaement, 1)
                    let cage: Int = Int(sqlite3_column_int(queryStaement,2))
                    let cavatar = sqlite3_column_text(queryStaement, 3)
                
                    
                    
                    let name = String(cString: cname!)
                    let avatar = String(cString: cavatar!)
                
                    
                    
                    let data : UsersClass = UsersClass(Int32(Id), name: name, age: Int32(cage), avatar: avatar)
                    
                    user.append(data)
                    print("Query Result")
                    print("\(Id) | \(name) |\(cage)  |\(avatar) ")
                    
                    
                }
                sqlite3_finalize(queryStaement)
                
            }
            else {
                
                print("Select Couldnt be prepared")
            }
            sqlite3_close(db)
        }
        else
        {
            print("Unable to open Database")
            
        }
        
    }
    func deleteUserFromTable(id: Int) ->Bool
    {
        
        var db : OpaquePointer? = nil
        var returnCode = false
        
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            
            var deleteStatement : OpaquePointer? = nil
            var deleteQuery : String = "delete from users where Id = ?"
            
            if sqlite3_prepare_v2(db, deleteQuery, -1, &deleteStatement, nil) == SQLITE_OK {
                
                sqlite3_bind_int(deleteStatement, 1, Int32(id))
                
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    print("Deleted task \(id)")
                    returnCode = true
                } else {
                    print("Could not delete user \(id)")
                }
                
                sqlite3_finalize(deleteStatement)
            } else {
                print("Could not prepare delete user statement")
            }
            
            sqlite3_close(db)
        } else {
            print("Could not open database")
        }
        
        return returnCode

        
    }

    func signUp(user : UsersClass) -> Bool
    {
        var db : OpaquePointer? = nil
        var returnCode : Bool = true
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK
        {
            var insertStatement : OpaquePointer? = nil
            let insertStatementString = "insert into users values(NULL,?,?,?)"
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK
            {
                let nameStr = user.name as NSString
                let avatarStr = user.avatar as NSString
           
                
                sqlite3_bind_text(insertStatement, 1, nameStr.utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 2, Int32(user.age))
                sqlite3_bind_text(insertStatement, 3, avatarStr.utf8String, -1, nil)
        
                
                if sqlite3_step(insertStatement) == SQLITE_DONE{
                    let rowId = sqlite3_last_insert_rowid(db)
                    print("Succeful inserted \(rowId)")
                }
                else{
                    print("Could not insert user")
                    returnCode = false
                }
                sqlite3_finalize(insertStatement)
            }
            else {print("Could not prepare insert user statement")
                returnCode = false
            }
            sqlite3_close(db)
        }
        else {
            print("Unable to open Db")
            returnCode = false
        }
        return returnCode
    }
    
    func checkAndCreateDatabase()
    {
        var success = false
        let fileManager = FileManager.default
        
        success = fileManager.fileExists(atPath: databasePath!)
        
        if success {
            return
            
        }
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        
        try?fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
        return
    }
    
    
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

