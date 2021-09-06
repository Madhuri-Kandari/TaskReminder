//
//  DataModel.swift
//  TaskReminder
//
//  Created by M1066900 on 09/06/21.
//

import UIKit

class DataModel{
    
    var taskLists = [TaskList]()
    
    var indexOfTasksList: Int{
        get{
            return UserDefaults.standard.integer(forKey: "TaskListIndex")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "TaskListIndex")
        }
    }
    
    init(){
          print(openFileDirectory())
          print(dataFilePath())
        loadFiles()
        regDefaults()
    }
    
    func regDefaults(){
        let dictionary = ["TaskListIndex":-1] as [String:Any]
        UserDefaults.standard.register(defaults: dictionary)
    }

    //MARK: - Files
        
        func openFileDirectory()->URL{
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
        
        func dataFilePath()-> URL{
            return openFileDirectory().appendingPathComponent("TaskLists.plist")
        }
        
        func saveFiles(){
            let encoder = PropertyListEncoder()
            do{
                let data = try encoder.encode(taskLists)
                try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
            }catch{
                print("Error! : \(error.localizedDescription)")
            }
        }
        
        func loadFiles(){
            let path = dataFilePath()
            if let data = try? Data(contentsOf: path){
                let decoder = PropertyListDecoder()
                do{
                    taskLists = try decoder.decode([TaskList].self, from: data)
                }catch{
                    print("Error! : \(error.localizedDescription)")
                }
            }
        }
    static func nextTaskItemID()->Int{
        let userDefaults=UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "TaskItemID")
        userDefaults.set(itemID+1, forKey: "TaskItemID")
        return itemID
    }
}
