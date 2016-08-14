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
        let bitmapInfo = CGImageAlphaInfo.PremultipliedLast.rawValue | CGBitmapInfo.ByteOrder32Little.rawValue
        return CGBitmapContextCreate(bitmap, width, height, 8, width * 4, colorSpace, bitmapInfo)!
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        Plotter.setBitmap(bitmap_, bitmapWidth_, bitmapHeight_)
        Plotter.clear(Color.White.rawValue)
        //Plotter.drawLine(100, 0, 0, 100, Color.White.rawValue)
        //Plotter.drawLine(0, 0, 100, 100, Color.White.rawValue)
        
        // 図形を書いてみる
        let triangle = [
            Vertex(x:160, y:70),
            Vertex(x:190, y:130),
            Vertex(x:130, y:130)
        ]
        
        let shape = Shape(
            color: Color.Red.rawValue,
            vertex: triangle
        )
        
        Plotter.drawShape(shape)
        
        /////////////////////////
        
        
        let rect = CGRectMake(0, 0, CGFloat(bitmapWidth_), CGFloat(bitmapHeight_))
        let image = CGBitmapContextCreateImage(context_)
        let windowContext = NSGraphicsContext.currentContext()!.CGContext
        CGContextDrawImage(windowContext, rect, image)
        
        
        // とりあえずビットマップを生成して、そこに描画して、それを表示してみる。
        // それから、ビットマップをplotter内で保持するようにしてみる。
        // または、ビットマップの生成はこちらで行い、plotterに渡すか？
    }
    
}
