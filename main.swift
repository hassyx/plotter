// IBを使わないMacアプリ作成についてはここ参照
// http://qiita.com/armorik83/items/92f2b8d9c94750e39592
// http://stackoverflow.com/questions/17583744/creating-an-osx-application-without-xcode
// https://gist.github.com/lucamarrocco/2b06c92e4e6df01de04b

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    let app: NSApplication
    let controller: NSWindowController
    
    init(app: NSApplication) {
        self.app = app
        self.controller = NiblessWindowController()
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        println("application started!")
        controller.showWindow(nil)
        app.activateIgnoringOtherApps(true)
    }
    
    func applicationWillTerminate(aNotification: NSNotification?) {
        println("application terminated!")
    }
    
    func applicationShouldTerminateAfterLastWindowClosed() -> Bool {
        return true
    }
}

class Menu {
    let app: NSApplication
    
    init(app: NSApplication) {
        self.app = app
        self.app.menu = mainMenu()
    }
    
    func mainMenu() -> NSMenu {
        let tree = [
            "Apple": [
                NSMenuItem(title: "Quit",  action: "terminate:", keyEquivalent:"q"),
            ],
            ]
        let result = NSMenu(title: "MainMenu")
        for (title, items) in tree {
            let menu = NSMenu(title: title)
            if let item = result.addItemWithTitle(title, action: nil, keyEquivalent:"") {
                result.setSubmenu(menu, forItem: item)
                for item in items {
                    menu.addItem(item)
                }
            }
        }
        return result
    }
}

class NiblessWindowController: NSWindowController {
    required init(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    override init() {
        super.init(window: nil)
        let rect = NSMakeRect(0, 0, 480, 320)
        let style = NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask
        let window = NSWindow(contentRect:rect, styleMask:style, backing:.Buffered, defer:false)
        window.title = "App"
        self.window = window
    }
}

let app = NSApplication.sharedApplication()
let delegate = AppDelegate(app: app)
app.delegate = delegate

let menu = Menu(app: app)

app.setActivationPolicy(.Regular)
atexit_b { app.setActivationPolicy(.Prohibited); return }
app.run()