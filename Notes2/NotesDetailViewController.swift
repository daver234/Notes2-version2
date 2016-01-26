//
//  NotesDetailViewController.swift
//  Notes2
//
//  Created by David Rothschild on 1/25/16.
//  Copyright © 2016 Dave Rothschild. All rights reserved.
//

import UIKit

class NotesDetailViewController: UITableViewController {
    
    weak var delegate: NotesDetailViewControllerDelegate?
    
    var tasks: [Task] = Task.all()
    
    var newTaskToEdit: Task?
    
    @IBOutlet weak var newTaskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
//        self.navigationItem.leftBarButtonItem = newBackButton;
        newTaskTextField.text = newTaskToEdit?.objective
    }
    
    
    @IBAction func backBarButtonPressed(sender: UIBarButtonItem) {
        if let task = newTaskToEdit {
            task.objective = newTaskTextField.text!
            delegate?.noteDetailViewController(self, didFinishEditingTask: task)
        } else {
            let task = Task(obj: newTaskTextField.text!)
            delegate?.noteDetailViewController(self, didFinishAddingTask: task.objective)
        }
    }

    
    
    
//    override func viewWillDisappear(animated : Bool) {
//        super.viewWillDisappear(animated)
//        
//        if (self.isMovingFromParentViewController()){
//            // Your code...
//        }
//    }
    
//    override func didMoveToParentViewController(parent: UIViewController?) {
//        if parent == nil {
//            //"Back pressed"
//        }
//    }
    
//    func back(sender: UIBarButtonItem) {
//        if let task = newTaskToEdit {
//            task.objective = newTaskTextField.text!
//            delegate?.noteDetailViewController(self, didFinishEditingTask: task)
//        } else {
//            let task = Task(obj: newTaskTextField.text!)
//            delegate?.noteDetailViewController(self, didFinishAddingTask: task.objective)
//        }
//        self.navigationController?.popViewControllerAnimated(true)
//    }
    
    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let dequeued: AnyObject = tableView.dequeueReusableCellWithIdentifier("NotesDetailCell", forIndexPath: indexPath)
//        
//        let cell = dequeued as! UITableViewCell
//        
//        cell.textLabel?.text = tasks[indexPath.row].objective
//        
//        return cell
//
//    }
    
}
