//
//  NotesDetailViewControllerDelegate.swift
//  Notes2
//
//  Created by David Rothschild on 1/25/16.
//  Copyright © 2016 Dave Rothschild. All rights reserved.
//

import UIKit
protocol NotesDetailViewControllerDelegate: class {
    func noteDetailViewController(controller: NotesDetailViewController, didFinishAddingTask task: String)
    func noteDetailViewController(controller: NotesDetailViewController, didFinishEditingTask task: Task)
}
