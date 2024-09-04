//
//  GearView.swift
//  TestTaskStarLine
//
//  Created by Юрий Яковлев on 03.09.2024.
//

import UIKit

class GearView: UIView {
    
    typealias Point = (point: CGPoint, radius: CGFloat)
    
    private let gridSize: CGFloat = 20.0
    
    var radius: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var cornerRadius: CGFloat = 10.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var toothHeight: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var toothCount: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard toothCount >= 2, radius >= 1, toothHeight >= 0 else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.clear(rect)
        
        drawGrid(in: rect, context: context)
        drawRuler(in: rect)
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        let angleStep = 2 * CGFloat.pi / CGFloat(toothCount)
        
        let path = UIBezierPath()
        
        var points: [Point] = []
        
        for i in 0..<toothCount {
            let angle = CGFloat(i) * angleStep
            let startPoint = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            let toothTip = CGPoint(x: center.x + (radius + toothHeight) * cos(angle + angleStep / 2), y: center.y + (radius + toothHeight) * sin(angle + angleStep / 2))
            
            points.append( (point: startPoint, radius: cornerRadius) )
            points.append( (point: toothTip, radius: cornerRadius) )
        }
        
        addArcs(to: path, points: points)
        
        path.close()
        
        UIColor.black.setStroke()
        path.lineWidth = 2.0
        path.stroke()
    }
    
    private func drawGrid(in rect: CGRect, context: CGContext) {
        context.setStrokeColor(UIColor.lightGray.cgColor)
        context.setLineWidth(0.5)
        
        for x in stride(from: gridSize, to: rect.width, by: gridSize) {
            context.move(to: CGPoint(x: x, y: 0))
            context.addLine(to: CGPoint(x: x, y: rect.height))
        }
        
        for y in stride(from: gridSize, to: rect.height, by: gridSize) {
            context.move(to: CGPoint(x: 0, y: y))
            context.addLine(to: CGPoint(x: rect.width, y: y))
        }
        
        context.strokePath()
    }
    
    private func drawRuler(in rect: CGRect) {
        let centerX = rect.width / 2
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 8),
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.black
        ]
        
        let numberOfDivisions = Int(rect.width / gridSize)
        
        for i in stride(from: -numberOfDivisions / 2, through: numberOfDivisions / 2, by: 1) {
            let xPosition = centerX + CGFloat(i) * gridSize
            let rulerValue = i * Int(gridSize)
            
            let text = "\(rulerValue)"
            let textRect = CGRect(x: xPosition - gridSize / 2, y: rect.height - 15, width: gridSize, height: 15)
            
            text.draw(in: textRect, withAttributes: attrs)
        }
    }
}

extension GearView {
    
    func addArcs(to path: UIBezierPath, points: [Point]) {
        for i in 0..<points.count {
            let (previous, current, next) = points.items(at: i)
            let (center, startAngle, endAngle, clockwise) = CGPoint.arcInfo(
                previous: previous.point,
                current: current.point,
                next: next.point,
                radius: current.radius)
            
            path.addArc(withCenter: center, radius: current.radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        }
    }
}
