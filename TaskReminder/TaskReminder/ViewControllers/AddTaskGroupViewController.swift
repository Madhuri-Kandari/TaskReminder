//
//  AddTaskGroupViewController.swift
//  TaskReminder
//
//  Created by M1066900 on 08/06/21.
//

import UIKit

protocol AddTaskGroupControllerDelegate:AnyObject {
    func addTaskGroupControllerDidCancel(_ controller:AddTaskGroupViewController)
    func addTaskGroupController(_ controller:AddTaskGroupViewController, didFinishAdding taskGroup:TaskList)
    func addTaskGroupController(_ controller:AddTaskGroupViewController, didFinishEditing taskGroup:TaskList)

}

class AddTaskGroupViewController: UITableViewController, UITextFieldDelegate{

    
   
    
    //
    @IBOutlet weak var newTextGroupField: UITextField!
    
    @IBOutlet weak var doneGroupOutlet: UIBarButtonItem!
    var editGroupTask : TaskList?
    
    weak var delegate:AddTaskGroupControllerDelegate?

//MARK: - VIEWCONTROLLERS

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let editGroupTask = editGroupTask {
            title = "Edit Task Group"
            newTextGroupField.text = editGroupTask.name
            print(newTextGroupField.text!)
            doneGroupOutlet.isEnabled = true
        }
        doneGroupOutlet.isEnabled=false
        // Do any additional setup after loading the view.
    }
        
        override func viewWillAppear(_ animated: Bool) {
            print("viewWillAppear in AddTaskGroupViewController")
            super.viewWillAppear(animated)
            newTextGroupField.becomeFirstResponder()
        }
        override func viewDidAppear(_ animated: Bool) {
            print("viewDidAppear in AddTaskGroupViewController")
            super.viewDidAppear(animated)
        }
        override func viewWillDisappear(_ animated: Bool) {
            print("viewWillDisppear in AddTaskGroupViewController")
            super.viewWillDisappear(animated)
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            print("viewDidDisppear in AddTaskGroupViewController")
            super.viewDidDisappear(animated)
        }
    
//    func Hey(){
//        print("Hello mady!")
//    }
    
    //MARK: - Actions
        @IBAction func CancelG(){
            //Step3: call the delegate method
            delegate?.addTaskGroupControllerDidCancel(self)
        }
        
        @IBAction func DoneG(){
            //Step3: call the delegate method
            let taskGroup = TaskList()
            taskGroup.name = newTextGroupField.text!
            if let editTaskGroup = editGroupTask{
                editTaskGroup.name=newTextGroupField.text!
                delegate?.addTaskGroupController(self, didFinishEditing: editTaskGroup)
            }else{
                delegate?.addTaskGroupController(self, didFinishAdding: taskGroup)
            }
        }
    
    //MARK: - Table view delegate
        override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
            return nil
        }
        
    //MARK: - Text field delegate
    
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let oldTaskGroup = textField.text!
            let stringRange = Range(range, in: oldTaskGroup)!
            let newTaskGroup = oldTaskGroup.replacingCharacters(in: stringRange, with: string)
            doneGroupOutlet.isEnabled = !newTaskGroup.isEmpty
            return true
        }
        
        func textFieldShouldClear(_ textField: UITextField) -> Bool {
            doneGroupOutlet.isEnabled = false
            return true
        }

}


