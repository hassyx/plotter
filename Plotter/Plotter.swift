//
//  Plotter.swift
//  Plotter
//
//  Created by hassy on 2016/08/10.
//  Copyright © 2016年 hassy. All rights reserved.
//

import Cocoa

enum Color: UInt32 {
    case Black =    0
    case White =    0xFFFFFFFF
    case Red =      0xFF0000FF
    case Green =    0x00FF00FF
    case Blue =     0x0000FFFF
}

struct Vertex {
    var x: Int
    var y: Int
}

struct Shape {
    var color: UInt32
    var vertex: [Vertex]
}

func makeColor(r: UInt8, _ g: UInt8, _ b: UInt8, _ a: UInt8) -> UInt32 {
    return UInt32(r) << 24 | UInt32(g) << 16 | UInt32(b) << 8 | UInt32(a)
}

class Plotter {
    // RGBA 32bit
    static var bitmap_: UnsafeMutablePointer<Void>?
    static var width_: Int = 0
    static var height_: Int = 0
    
    // 毎回ビットマップを渡す。
    // そのあとplot()を呼び出すと、そのビットマップに描画を行う。
    
    static func setBitmap(bitmap: UnsafeMutablePointer<Void>, _ width: Int, _ height: Int) {
        bitmap_ = bitmap
        width_ = width
        height_ = height
    }
    
    static func plot(x: Int, _ y: Int, _ r: UInt8, _ g: UInt8, _ b: UInt8, _ a: UInt8) {
        Plotter.plot(x, y, makeColor(r, g, b, a))
    }
    
    static func plot(x: Int, _ y: Int, _ color: UInt32) {
        let dst = UnsafeMutablePointer<UInt32>(bitmap_!)
        dst.advancedBy(y * width_ + x).memory = color
    }
    
    static func clear(r: UInt8, _ g: UInt8, _ b: UInt8, _ a: UInt8) {
        Plotter.clear(makeColor(r, g, b, a))
    }
    
    static func clear(color: UInt32) {
        let dst = UnsafeMutablePointer<UInt32>(bitmap_!)
        
        for i in 0..<height_ {
            for j in 0..<width_ {
                dst.advancedBy(i * height_ + j).memory = color
            }
        }
    }
    
    static func drawLine(x1: Int, _ y1: Int, _ x2: Int, _ y2: Int, _ r: UInt8, _ g: UInt8, _ b: UInt8, _ a: UInt8) {
        Plotter.drawLine(x1, y1, x2, y2, makeColor(r, g, b, a))
    }
    
    static func drawLine(x1: Int, _ y1: Int, _ x2: Int, _ y2: Int, _ color: UInt32) {
        // x_unitはxの増分、y_unitはyの増分。
        var x_unit = 0
        var y_unit = 0
        
        // ydiffはyが最終的にどれだけ移動するかの絶対値。
        // もしyが減る場合、y_unitは負になる。
        var ydiff = y2 - y1
        if ydiff < 0 {
            ydiff = -ydiff
            y_unit = -width_
        } else {
            y_unit = width_
        }
        
        // xdiffはxが最終的にどれだけ移動するかの絶対値。
        // もしxが減る場合、x_unitは負になる。
        var xdiff = x2 - x1
        if xdiff < 0 {
            xdiff = -xdiff
            x_unit = -1
        } else {
            x_unit = 1
        }
        
        let dst = UnsafeMutablePointer<UInt32>(bitmap_!)
        
        // 描画先メモリのスタート位置。
        // xまたはyが増える場合、この値はループを重ねるごとにunit分増え続ける。
        // xまたはyが減る場合、この値はループを重ねるごとにunit分減り続ける。
        var offset = y1 * width_ + x1
        
        if xdiff > ydiff {
            // 傾きが1より小さい場合。
            // ループを回す際に必ずxを増分させる。
            // xを増分するたびにerror_termにfdiffを加算し、
            // error_termがxdiffを超えた際に初めてyを増やす。
            var error_term = 0
            let length = xdiff + 1
            for _ in 0..<length {
                dst.advancedBy(offset).memory = color
                offset += x_unit
                error_term += ydiff
                if error_term > xdiff {
                    error_term -= xdiff
                    offset += y_unit
                }
            }
        } else {
            // 傾きが1より大きい場合、または1の場合。
            // ループを回す際にyを必ず増分させる。
            // yを増分するたびにerror_termにxdiffを加算し、
            // error_termがydiffを超えた際に初めてxを増やす。
            var error_term = 0
            let length = ydiff + 1
            for _ in 0..<length {
                dst.advancedBy(offset).memory = color
                offset += y_unit
                error_term += xdiff
                if error_term > ydiff {
                    error_term -= ydiff
                    offset += x_unit
                }
            }
        }
    }
    
    static func drawShape(shape: Shape) {
        for i in 0..<shape.vertex.count {
            let p1 = shape.vertex[i]
            let p2 = i+1 >= shape.vertex.count ?
                shape.vertex[0] :
                shape.vertex[i+1]
         
            Plotter.drawLine(p1.x, p1.y, p2.x, p2.y, shape.color)
        }
    }
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
