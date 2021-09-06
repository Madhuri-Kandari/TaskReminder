//
//  AddTaskController.swift
//  TaskReminder
//
//  Created by M1066900 on 03/06/21.
//

import UIKit
//Controller B 
//Step1 : Create the protocol
protocol AddTaskControllerDelegate:AnyObject {
    func addTaskControllerDidCancel(_ controller:AddTaskController)
    func addTaskController(_ controller:AddTaskController, didFinishAdding task:Task)
    func addTaskController(_ controller:AddTaskController, didFinishEditing task:Task)

}

class AddTaskController: UITableViewController,UITextFieldDelegate{

    
//    @IBOutlet var shouldRemindSwitch:UISwitch!
//    @IBOutlet var datePicker: UIDatePicker!
    
    
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var newTextField: UITextField!
    
    @IBOutlet weak var doneOutlet: UIBarButtonItem!
    var editTask : Task?

    weak var delegate:AddTaskControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let task = editTask {
            title = "Edit Task"
          newTextField.text = task.text
            doneOutlet.isEnabled = true
            shouldRemindSwitch.isOn=task.shouldRemind
            datePicker.date=task.dueDate
        }
        doneOutlet.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       newTextField.becomeFirstResponder()
    }
//MARK: - Actions
    @IBAction func remindToggle(_ switchToggle: UISwitch){
        newTextField.resignFirstResponder()
        if switchToggle.isOn{
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert,.sound]) { _,_ in}
            }
        }
    
    @IBAction func cancel(){
        delegate?.addTaskControllerDidCancel(self)
        
    }
    
    @IBAction func done(){
        let task = Task()
        task.text = newTextField.text!
        if let editTask = editTask{
          editTask.text = newTextField.text!
            editTask.dueDate=datePicker.date
            editTask.scheduleNotification()
            delegate?.addTaskController(self, didFinishEditing: editTask)
        }else{
            let task=Task()
            task.text=newTextField.text!
            task.shouldRemind=shouldRemindSwitch.isOn
            task.dueDate=datePicker.date
            task.scheduleNotification()
            delegate?.addTaskController(self, didFinishAdding: task)
        }
    }
    
    
    
//MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
    
        doneOutlet.isEnabled = !newText.isEmpty
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneOutlet.isEnabled = false
        return true
    }
    
    //MARK:- Schedule Notification
    
}
