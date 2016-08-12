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
}