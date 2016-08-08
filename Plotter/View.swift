//
//  View.swift
//  Plotter
//
//  Created by hassy on 2016/08/06.
//  Copyright © 2016年 hassy. All rights reserved.
//

import Cocoa

class View: NSView {
    
    let context_: CGContext
    let bitmap_: UnsafeMutablePointer<Void>
    let bitmapWidth_: Int
    let bitmapHeight_: Int
    
    required init(coder: NSCoder) {
        bitmapWidth_ = 640
        bitmapHeight_ = 480
        bitmap_ = View.createBitmap(bitmapWidth_, bitmapHeight_)
        context_ = View.initializeContext(bitmap_, bitmapWidth_, bitmapHeight_)
        
        super.init(coder: coder)!
    }
    
    override init(frame: NSRect) {
        bitmapWidth_ = Int(frame.size.width)
        bitmapHeight_ = Int(frame.size.height)
        bitmap_ = View.createBitmap(bitmapWidth_, bitmapHeight_)
        context_ = View.initializeContext(bitmap_, bitmapWidth_, bitmapHeight_)
        
        super.init(frame: frame)
    }
    
    static func createBitmap(width: Int, _ height: Int) -> UnsafeMutablePointer<Void> {
        return UnsafeMutablePointer<Void>(malloc(width * height * 4))
    }
    
    static func initializeContext(bitmap: UnsafeMutablePointer<Void>, _ width: Int, _ height: Int) -> CGContext {
        let colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB)
        return CGBitmapContextCreate(bitmap, width, height, 8, width * 4, colorSpace, CGImageAlphaInfo.PremultipliedLast.rawValue)!
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
        
        // ここのコードがよくわからない。
        // あとで調べて見る。
        
        //let cont = NSGraphicsContext.currentContext()?.CGContext
        let rect = CGRectMake(0, 0, CGFloat(bitmapWidth_), CGFloat(bitmapHeight_))
        
        CGContextSetRGBFillColor(context_, 1, 0, 0, 0.5)
        CGContextFillRect(context_, rect)
        
        let image = CGBitmapContextCreateImage(context_)
        
        let windowContext = NSGraphicsContext.currentContext()!.CGContext
        
        CGContextDrawImage(windowContext, rect, image)
        
        
        // とりあえずビットマップを生成して、そこに描画して、それを表示してみる。
        // それから、ビットマップをplotter内で保持するようにしてみる。
        // または、ビットマップの生成はこちらで行い、plotterに渡すか？
        
        
        /*
        let context = NSGraphicsContext.currentContext()?.CGContext
        let bitmap = CGBitmapContextGetData(context)
        */
        
        
        
        /*
        var bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
        let fillColor = NSColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
        fillColor.set()
        bPath.fill()
        
        let borderColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        borderColor.set()
        bPath.lineWidth = 12.0
        bPath.stroke()
        
        let circleFillColor = NSColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        var circleRect = NSMakeRect(dirtyRect.size.width/4, dirtyRect.size.height/4, dirtyRect.size.width/2, dirtyRect.size.height/2)
        var cPath: NSBezierPath = NSBezierPath(ovalInRect: circleRect)
        circleFillColor.set()
        cPath.fill()
        */
    }
    
}
