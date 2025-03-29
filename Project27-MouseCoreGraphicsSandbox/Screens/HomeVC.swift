//  File: HomeVC.swift
//  Project: Project27-MouseCoreGraphicsSandbox
//  Created by: Noah Pope on 3/24/25.

import UIKit

class HomeVC: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print(UIScreen.main.bounds.size)
        drawEmoji()
    }

    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1

        if currentDrawType > 6 { currentDrawType = 0 }

        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerBoard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawFunnelWithLines()
        case 5:
            drawMouseAndText()
        case 6:
            drawEmoji()
        default:
            break
        }
    }

    //-------------------------------------//
    // MARK: SHAPE RENDERING METHODS
    /*
     DRAWING STEPS
     1. make a global UIImageView
     2. make a renderer of a certain CGSize
     3. in said renderer's image method's closure create a CGRectangle (main thing you'll
     ... see) the same size as the renderer
     > note: you can skip this step and step 5 if you're using the .fill(CGRect...) method
     4. draw on your context/canvas using the context's cgContext props
     5. add your rectangle || circle containing the drawing to said cgContext using
     ... a combo of the addRect & drawPath methods

     TERMINOLOGY & LOGIC
     ctx = thin wrapper around CGContext = a canvas upon which we can draw, accessed using
     ... *.cgContext
     the rectangle const inside the closure is the space our shape will be drawn on
     the stroke straddles the edge of said rectangle so the *.insetBy method indents
     ... said rectangle so the stroke exists within the desired bounds
     ... logic = half the value of the line width since the stroke straddles the center
     for circles instead of rectangles, replace *.addRect with *.addEllipse within the
     ... display rect
     */

    func drawRectangle() {
        let renderer    = UIGraphicsImageRenderer(
            size: CGSize(width: 512, height: 512))

        let img         = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
                .insetBy(dx: 10, dy: 10)

            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(20)

            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imageView.image = img
    }

    func drawCircle() {
        let renderer    = UIGraphicsImageRenderer(
            size: CGSize(width: 512, height: 512))

        let img         = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
                .insetBy(dx: 10, dy: 10)

            ctx.cgContext.setFillColor(UIColor.systemPink.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.systemPurple.cgColor)
            ctx.cgContext.setLineWidth(20)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imageView.image = img
    }

    func drawCheckerBoard() {
        let renderer    = UIGraphicsImageRenderer(
            size: CGSize(width: 512, height: 512))

        let img         = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)

            for row in 0..<8 {
                for col in 0..<8 {
                    guard (row + col) % 2 == 0 else { continue }
                    ctx.cgContext.fill(
                        CGRect(
                            x: col * 64,
                            y: row * 64,
                            width: 64,
                            height: 64)
                    )
                }
            }

        }

        imageView.image = img
    }
    
    
    func drawRotatedSquares()
    {
        let renderer    = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img         = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations   = 16
            let amount      = Double.pi / Double(rotations)
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    
    func drawFunnelWithLines()
    {
        let renderer    = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img         = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first           = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)
                if first { ctx.cgContext.move(to: CGPoint(x: length, y: 50)); first = false }
                else { ctx.cgContext.addLine(to: CGPoint(x: length, y: 50)) }
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    
    func drawMouseAndText()
    {
        let renderer    = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img         = renderer.image { ctx in
            let paragraphStyle          = NSMutableParagraphStyle()
            paragraphStyle.alignment    = .center
            
            let attrs: [NSAttributedString.Key : Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle,
            ]
            
            let string              = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString    = NSAttributedString(string: string, attributes: attrs)
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448),
                                  options: .usesLineFragmentOrigin,
                                  context: nil)
            
            let mouse               = UIImage(named: ImageKeys.mouse)
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        
        imageView.image = img
    }
    
    
    func drawEmoji()
    {
        let renderer    = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img         = renderer.image { ctx in
            // HEAD
            let rectangle   = CGRect(x: 0, y: 0, width: 512, height: 512)
                .insetBy(dx: 15, dy: 15)
            
            ctx.cgContext.setFillColor(UIColor.systemYellow.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(30)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            // LEFT EYE
            let rectangle2  = CGRect(x: 80, y: 215, width: 120, height: 0)
            
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(15)
            
            ctx.cgContext.addRect(rectangle2)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            // RIGHT EYE
            let rectangle3  = CGRect(x: 290, y: 215, width: 120, height: 0)
            
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(15)
            
            ctx.cgContext.addRect(rectangle3)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            // MOUTH
            let rectangle4  = CGRect(x: 190, y: 380, width: 120, height: 0)
            
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(15)
            
            ctx.cgContext.addRect(rectangle4)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
}

//func drawRectangle() {
//    let renderer    = UIGraphicsImageRenderer(
//        size: CGSize(width: 512, height: 512))
//
//    let img         = renderer.image { ctx in
//        let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
//            .insetBy(dx: 10, dy: 10)
//
//        ctx.cgContext.setFillColor(UIColor.red.cgColor)
//        ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
//        ctx.cgContext.setLineWidth(20)
//
//        ctx.cgContext.addRect(rectangle)
//        ctx.cgContext.drawPath(using: .fillStroke)
//    }
//
//    imageView.image = img
//}
