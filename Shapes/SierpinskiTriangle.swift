//
//  SierpinskiTriangle.swift
//  Shapes
//
//  Created by Nicholas Alba on 8/30/21.
//

import UIKit

class SierpinskiTriangle: UIView {

    init(frame: CGRect, length: CGFloat, iterations: Int) {
        self.length = length
        self.iterations = iterations
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let currentContext = UIGraphicsGetCurrentContext() else {return}
        context = currentContext
        context.setFillColor(UIColor.black.cgColor)
        
        let a = CGPoint(x: rect.midX, y: 10)
        let b = CGPoint(x: a.x - halfLength, y: a.y + rootThreeOverTwoTimesLength)
        let c = CGPoint(x: a.x + halfLength, y: a.y + rootThreeOverTwoTimesLength)
        let triangle = Triangle(a: a, b: b, c: c)
        
        context.move(to: triangle.a)
        context.addLine(to: triangle.b)
        context.addLine(to: triangle.c)
        context.addLine(to: triangle.a)
        context.fillPath()
        triangles.append(triangle)
        
        context.setFillColor(UIColor.white.cgColor)
        
        evolve(withRemainingEvolutions: iterations)
    }
    
    func evolve(withRemainingEvolutions remainingEvolutions: Int) {
        if remainingEvolutions == 0 {
            return
        }
        
        var newTriangles:[Triangle] = []
        for _ in 0..<triangles.count {
            let poppedTriangle = triangles.removeFirst()
            let aPrime = CGPoint(x: (poppedTriangle.a.x+poppedTriangle.b.x) / 2, y: (poppedTriangle.a.y+poppedTriangle.b.y) / 2)
            let bPrime = CGPoint(x: poppedTriangle.a.x, y: poppedTriangle.b.y)
            let cPrime = CGPoint(x: (poppedTriangle.a.x+poppedTriangle.c.x) / 2, y: (poppedTriangle.a.y+poppedTriangle.c.y) / 2)
            
            context.move(to: aPrime)
            context.addLine(to: bPrime)
            context.addLine(to: cPrime)
            context.addLine(to: aPrime)
            context.fillPath()
            
            newTriangles.append(Triangle(a: poppedTriangle.a, b: aPrime, c: cPrime))
            newTriangles.append(Triangle(a: aPrime, b: poppedTriangle.b, c: bPrime))
            newTriangles.append(Triangle(a: cPrime, b: bPrime, c: poppedTriangle.c))
        }
        triangles.append(contentsOf: newTriangles)
        
        evolve(withRemainingEvolutions: remainingEvolutions - 1)
    }
    
    private var halfLength: CGFloat {
        return length / 2
    }
    
    private var rootThreeOverTwoTimesLength: CGFloat {
        return sqrt(3)/2 * length
    }
    
    private let length: CGFloat
    private let iterations: Int
    private var triangles: [Triangle] = []
    private var context: CGContext!
}


struct Triangle {
    
    var a: CGPoint
    var b: CGPoint
    var c: CGPoint
}
