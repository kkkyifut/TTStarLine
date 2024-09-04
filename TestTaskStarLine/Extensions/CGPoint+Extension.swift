//
//  CGPoint+Extension.swift
//  TestTaskStarLine
//
//  Created by Юрий Яковлев on 04.09.2024.
//

import Foundation

extension CGPoint {
    
    init(angle: CGFloat) {
        self.init(x: cos(angle), y: sin(angle))
    }
    
    var angle: CGFloat {
        atan2(y, x)
    }
    
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func * (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x * right.x, y: left.y * right.y)
    }
    
    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    
    static func angleBetween3Points(_ a: CGPoint, _ b: CGPoint, _ c: CGPoint) -> CGFloat {
        let xbaAngle = (a - b).angle
        let xbcAngle = (c - b).angle
        let abcAngle = xbcAngle - xbaAngle
        return CGPoint(angle: abcAngle).angle
    }
    
    static func arcInfo(previous: CGPoint, current: CGPoint, next: CGPoint, radius: CGFloat) -> (center: CGPoint, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
        let a = previous
        let b = current
        let bCornerRadius: CGFloat = radius
        let c = next
        
        let abcAngle: CGFloat = angleBetween3Points(a, b, c)
        let xbaAngle = (a - b).angle
        let abeAngle = abcAngle / 2
        
        let deLength: CGFloat = bCornerRadius
        let bdLength = bCornerRadius / tan(abeAngle)
        let beLength = sqrt(deLength*deLength + bdLength*bdLength)
        
        let beVector: CGPoint = CGPoint(angle: abcAngle/2 + xbaAngle)
        
        let e: CGPoint = b + beVector * beLength
        
        let xebAngle = (b - e).angle
        let bedAngle = (.pi/2 - abs(abeAngle)) * (abeAngle >= 0.0 ? 1.0 : -1.0) * -1
        
        return (center: e, startAngle: xebAngle - bedAngle, endAngle: xebAngle + bedAngle, clockwise: abeAngle < 0)
    }
}
