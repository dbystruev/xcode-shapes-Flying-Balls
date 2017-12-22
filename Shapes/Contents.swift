//
//  Contents.swift
//  Shapes
//
//  Started by Denis Bystruev on 13/04/2017.
//  Copyright © 2017 Denis Bystruev. All rights reserved.
//  https://github.com/dbystruev
//  http://learnSwift.ru
//
//  The code below is derived from:
//  — Shapes template in Swift Playgrounds for iPad by Apple
//  — Converted Playgroundbooks by Kush Taneja (https://github.com/kushtaneja)

// Any code developed for Shapes template
// for Swift Playgrounds for iPad goes into this run() function of this class

class SwiftPlaygrounds {
    #if DEBUG || RELEASE
    // This code runs during DEBUG or RELEASE in Xcode
    let view = Canvas.shared.backingView
    #endif
    
    // The code to start with
    init() {
        #if DEBUG || RELEASE
            // This code runs in Xcode for Mac
            // Make the backgound white
            Canvas.shared.color = .white
        #else
            // This code runs in Swift Playgrounds for iPad
            run()
        #endif
    }
    
    // The code to run
    func run() {
        let colors = [#colorLiteral(red: 0.176470592617989, green: 0.498039215803146, blue: 0.756862759590149, alpha: 1.0), #colorLiteral(red: 0.176470592617989, green: 0.0117647061124444, blue: 0.560784339904785, alpha: 1.0), #colorLiteral(red: 0.572549045085907, green: 0.0, blue: 0.23137255012989, alpha: 1.0), #colorLiteral(red: 0.925490200519562, green: 0.235294118523598, blue: 0.10196078568697, alpha: 1.0), #colorLiteral(red: 0.952941179275513, green: 0.686274528503418, blue: 0.133333340287209, alpha: 1.0), #colorLiteral(red: 0.341176480054855, green: 0.623529434204102, blue: 0.168627455830574, alpha: 1.0)]
        let radius = 10.0
        var circles: [Circle] = []
        var points: [Point] = []
        var step = 0
        
        func newCircle(with color: Color) -> Circle {
            let circle = Circle(radius: radius)
            circle.color = color
            circle.borderColor = color.lighter()
            circle.borderWidth = 20
            return circle
        }
        
        func setup() {
            for color in colors {
                circles.insert(newCircle(with: color), at: 0)
                points.append(Point(x: 0, y: 0))
            }
        }
        
        func moveCircles() {
            animate(duration: 3, delay: 0, {
                for i in 0..<min(circles.count, points.count) {
                    circles[i].center = points[i]
                }
            })
        }
        
        func touchPoint() -> Point {
            return Canvas.shared.currentTouchPoints.first!
        }
        
        Canvas.shared.onTouchDrag {
            if step == 0 {
                points.removeLast()
                points.insert(touchPoint(), at: 0)
            } else {
                points[0] = touchPoint()
            }
            step = (step + 1) % 10
            moveCircles()
        }
        
        Canvas.shared.onTouchDown {
            let start = touchPoint()
            let end = points[0]
            let n = Double(points.count)
            let delta = Point(
                x: (end.x - start.x) / n,
                y: (end.y - start.y) / n
            )
            points[0] = start
            for i in 1 ..< points.endIndex {
                points[i].x = points[i - 1].x + delta.x
                points[i].y = points[i - 1].y + delta.y
            }
            moveCircles()
        }
        
        Canvas.shared.onTouchUp {
            let point = points[0]
            points = points.map { _ in point }
            moveCircles()
        }
        
        setup()
    }
}

#if !DEBUG && !RELEASE
    // This code runs in Swift Playgrounds for iPad
    import PlaygroundSupport
let _ = SwiftPlaygrounds()
#endif
