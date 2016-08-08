//
//  WindowController.swift
//  Plotter
//
//  Created by hassy on 2016/08/06.
//  Copyright © 2016年 hassy. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController, NSWindowDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()
        self.window!.delegate = self
    }

    func windowWillClose(notification: NSNotification) {
        NSApplication.sharedApplication().terminate(NSApp.keyWindow)
    }
}
