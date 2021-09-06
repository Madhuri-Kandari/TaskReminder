//
//  TaskViewController.swift
//  TaskReminder
//
//  Created by M1066900 on 03/06/21.
//

import UIKit
//Controller A 
class TaskViewController: UITableViewController, AddTaskControllerDelegate {
    
    //var tasks = [Task]()
    var taskList:TaskList!
    
    
    
    func addTaskControllerDidCancel(_ controller: AddTaskController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addTaskController(_ controller: AddTaskController, didFinishAdding task: Task) {
        let newRowIndex = taskList.tasksArray.count
        taskList.tasksArray.append(task)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
       // saveFiles()
        navigationController?.popViewController(animated: true)
    }
    
    func addTaskController(_ controller: AddTaskController, didFinishEditing task: Task) {
        if let index = taskList.tasksArray.firstIndex(of: task){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                let label = cell.viewWithTag(106) as! UILabel
                let taskItem = self.taskList.tasksArray[indexPath.row]
                label.text = taskItem.text
            }
        }
       // saveFiles()
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
      //  print(openFileDirectory())
        //print(dataFilePath())
      //  loadFiles()
    }
    
//MARK: - actions
    
    func configureCheckmark(for cell:UITableViewCell, with task:Task){
    }
    
//MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTask"{
            let controllerB = segue.destination as! AddTaskController
            controllerB.delegate = self
        }
        else if segue.identifier == "editTask"{
            let controllerB = segue.destination as! AddTaskController
            controllerB.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                let taskTapped = taskList.tasksArray[indexPath.row]
                controllerB.editTask = taskTapped
            }
        }
    }
    
//MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.tasksArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        let label = cell.viewWithTag(106) as! UILabel
        let taskItem = taskList.tasksArray[indexPath.row]
        label.text = "Id:\(taskItem.itemId) \(taskItem.text)"
        
        configureCheckmark(for: cell, with: taskItem)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        taskList.tasksArray.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
       // saveFiles()
    }
//MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if let cell = tableView.cellForRow(at: indexPath){
            let taskItem = taskList.tasksArray[indexPath.row]
            
            taskItem.toggleCheck()

            configureCheckmark(for: cell, with: taskItem)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


