//
//  TaskGroupViewController.swift
//  TaskReminder
//
//  Created by M1066900 on 08/06/21.
//

import UIKit

class TaskGroupViewController: UITableViewController, AddTaskGroupControllerDelegate, UINavigationControllerDelegate {

    
    let cellIdentifier="TaskGroupCell"
    var dataModel = DataModel()
    
    func addTaskGroupControllerDidCancel(_ controller:AddTaskGroupViewController){
        navigationController?.popViewController(animated: true)
    }
    func addTaskGroupController(_ controller:AddTaskGroupViewController, didFinishAdding taskGroup:TaskList){
        
        let newRowIndex = self.dataModel.taskLists.count
        self.dataModel.taskLists.append(taskGroup)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
        
    }
    func addTaskGroupController(_ controller:AddTaskGroupViewController, didFinishEditing taskGroup:TaskList){
        
        if let index = dataModel.taskLists.firstIndex(of: taskGroup){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                //Get the task for this row
                let taskGroupItem = self.dataModel.taskLists[indexPath.row]
                //set the data for the row
                cell.textLabel?.text=taskGroupItem.name
            }
        }
        navigationController?.popViewController(animated: true)
        
    }
//MARK: - VIEWCONTROLLERS
    
    override func viewDidLoad() {
        print("viewDidLoad in TaskGroupViewController")
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear in TaskGroupViewController")
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear in TaskGroupViewController")
        super.viewDidAppear(animated)
        navigationController?.delegate=self
        //user default
        //get the index from the userdefault and perform the segue,pass the tasklist
//        let index=dataModel.indexOfTasksList
//        if index >= 0{
//        let taskList=dataModel.taskLists[index]
//        performSegue(withIdentifier: "goToTask", sender: taskList)
//        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisppear in TaskGroupViewController")
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisppear in TaskGroupViewController")
        super.viewDidDisappear(animated)
    }
    
//    override func didReceiveMemoryWarning() {
//        print("didReceiveMemoryWarning in TaskGroupViewController")
//    }
    
    //MARK: - Navigation
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToTask"{
                let controllerB = segue.destination as? TaskViewController
                let taskList=sender as? TaskList
                controllerB?.taskList = taskList
                
            }
            else{
                let controllerB = segue.destination as! AddTaskGroupViewController
                controllerB.delegate = self
                if segue.identifier == "editGroupTask"{
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                    //getting the task to edit
                    let taskTapped = dataModel.taskLists[indexPath.row]
                    //assigning the tasks to controllerB property
                    controllerB.editGroupTask = taskTapped
                   // controllerB.Hey()
                }
                }
            }
        }
    
    //MARK: - table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.taskLists.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let taskGroupForTheRow:TaskList=dataModel.taskLists[indexPath.row]
        let taskListName=taskGroupForTheRow.name
        cell.textLabel?.text=taskListName
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.taskLists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
      //  saveFiles()
    }
    //MARK: - table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //user default
        //set the value for userdefault with index
        //get the tasklist object for this row
        dataModel.indexOfTasksList=indexPath.row
        let taskList=dataModel.taskLists[indexPath.row]
        performSegue(withIdentifier: "goToTask", sender: taskList)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let cell=tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "editGroupTask", sender: cell)
    }
    
    //MARK: - Navigation controller delegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //UserDefault
        //set the userdefault value as -1
        if viewController==self{
            dataModel.indexOfTasksList = -1
        }
    }
}
