//
//  ViewController.swift
//  Plotter
//
//  Created by hassy on 2016/08/06.
//  Copyright © 2016年 hassy. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func loadView() {
        self.view = View(frame: NSMakeRect(0, 0, 400, 400))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

