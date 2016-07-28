// IBを使わないMacアプリ作成についてはここ参照
// http://qiita.com/armorik83/items/92f2b8d9c94750e39592
// http://stackoverflow.com/questions/17583744/creating-an-osx-application-without-xcode
// https://gist.github.com/lucamarrocco/2b06c92e4e6df01de04b

import Cocoa

// Style flags:
let windowStyle = NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask;

// Window bounds (x, y, width, height).
let windowRect = NSMakeRect(100, 100, 400, 400);
let window =  NSWindow(
    contentRect: windowRect,
    styleMask: windowStyle,
    backing: .Buffered,
    defer: false
)

// Window controller:
let windowController = NSWindowController(window:window)

// TODO: Create app delegate to handle system events.
// TODO: Create menus (especially Quit!)

// Show window and run event loop.
window.orderFrontRegardless()
NSApplication.sharedApplication().run()
