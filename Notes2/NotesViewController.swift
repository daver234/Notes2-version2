//
//  ViewController.swift
//  Notes2
//
//  Created by David Rothschild on 1/25/16.
//  Copyright © 2016 Dave Rothschild. All rights reserved.
//

import UIKit

class NotesViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, NotesDetailViewControllerDelegate {
    
    
    var searchController = UISearchController(searchResultsController: nil)
    var filteredTasks = [Task]()
    
    var tasks: [Task] = Task.all()
    
    var isEditing: Bool?
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        isEditing = false
        performSegueWithIdentifier("NotesSegue", sender: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        isEditing = true
        performSegueWithIdentifier("NotesSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    
//    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
//    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredTasks = tasks.filter { task in
            return task.objective.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NotesSegue" {
            //self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.Plain, target:nil, action:nil)
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! NotesDetailViewController
            //controller.cancelButtonDelegate = self
            controller.delegate = self
            if isEditing! == true {
                if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                    controller.newTaskToEdit = tasks[indexPath.row]
                }
            }
        }
    }

    func noteDetailViewController(controller: NotesDetailViewController, didFinishAddingTask task: String) {
        dismissViewControllerAnimated(true, completion: nil)
        let task = Task(obj: task)
        task.save()
        //tasks = Task.all()
        tableView.reloadData()
    }
    func noteDetailViewController(controller: NotesDetailViewController, didFinishEditingTask task: Task) {
        dismissViewControllerAnimated(true, completion: nil)
        //var newDate = task.createdAt
        let newTaskDate = task.createdAt
        let newTaskName = task.objective
        task.destroy()
        let task = Task(obj: newTaskName)
        //task.createdAt = NSDate()
        task.save()
        //tasks = Task.all()
        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredTasks.count
        }
        tasks = Task.all()
        return tasks.count
    }
    
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tasks = Task.all()
//        return tasks.count
//    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dequeued: AnyObject = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath)
        let task: Task
        let cell = dequeued as! UITableViewCell
        
        if searchController.active && searchController.searchBar.text != "" {
            task = filteredTasks[indexPath.row]
        } else {
            task = tasks[indexPath.row]
            // cell.textLabel?.text = tasks[indexPath.row].objective
        }
        
        let dateformat = NSDateFormatter()
        dateformat.dateFormat = "MM-dd-yyyy"
      
        cell.detailTextLabel!.text = dateformat.stringFromDate(tasks[indexPath.row].createdAt)
//        cell.textLabel?.text = tasks[indexPath.row].objective
        cell.textLabel?.text = task.objective
        
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        tasks[indexPath.row].destroy()
        tasks.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
}


