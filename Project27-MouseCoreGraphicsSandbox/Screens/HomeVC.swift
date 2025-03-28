//  File: HomeVC.swift
//  Project: Project27-MouseCoreGraphicsSandbox
//  Created by: Noah Pope on 3/24/25.

import CoreImage.CIFilterBuiltins
import UIKit

class HomeVC: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0
    //    /**BONUS VARS**/
    //    var coreImageContext: CIContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(UIScreen.main.bounds.size)
        //        coreImageContext = CIContext()
        altDrawCheckerBoard()
    }

    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1

        if currentDrawType > 5 { currentDrawType = 0 }

        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerBoard()
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
        let renderer = UIGraphicsImageRenderer(
            size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(
                dx: 10, dy: 10)

            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(20)

            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imageView.image = img
    }

    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(
            size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(
                dx: 10, dy: 10)

            ctx.cgContext.setFillColor(UIColor.systemPink.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.systemPurple.cgColor)
            ctx.cgContext.setLineWidth(20)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imageView.image = img
    }

    func drawCheckerBoard() {
        let renderer = UIGraphicsImageRenderer(
            size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
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

    func altDrawCheckerBoard() {

//        let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)

        let checkerBoardGenerator       = CIFilter.checkerboardGenerator()
        checkerBoardGenerator.setDefaults()
        checkerBoardGenerator.center    = CGPoint(x: 0, y: 0)
        checkerBoardGenerator.color0    = .magenta
        checkerBoardGenerator.color1    = .yellow
        checkerBoardGenerator.width     = 64
        checkerBoardGenerator.sharpness = 1
        imageView.image = UIImage(ciImage: checkerBoardGenerator.outputImage!)
    }
}
