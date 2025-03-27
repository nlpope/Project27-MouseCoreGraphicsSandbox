//  File: HomeVC.swift
//  Project: Project27-MouseCoreGraphicsSandbox
//  Created by: Noah Pope on 3/24/25.

import UIKit

class HomeVC: UIViewController
{
    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(UIScreen.main.bounds.size)
        drawRectangle()
    }
    
    
    @IBAction func redrawTapped(_ sender: Any)
    {
        currentDrawType += 1
        
        if currentDrawType > 5 { currentDrawType = 0 }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            
        default:
            break
        }
    }
    
    //-------------------------------------//
    // MARK: SHAPE RENDERING METHODS
    
    func drawRectangle()
    {
        let renderer    = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img         = renderer.image { ctx in
            /*
             drawing code
             ctx = thin wrapper around CGContext = a canvas upon which we can draw
             ... accessed using *.cgContext
             the rectangle const inside the closure is the space our shape will be drawn on
             the stroke straddles the edge of said rectangle so the *.insetBy method indents
             ... said rectangle so the stroke exists within the desired bounds
             ... logic = half the value of the line width since the stroke straddles the center
             for circles instead of rectangles, replace *.addRect with *.addEllipse within the
             ... display rect
             */
            let rectangle   = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 10, dy: 10)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(20)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    
    func drawCircle()
    {
        let renderer    = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img         = renderer.image { ctx in
            let rectangle   = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 10, dy: 10)
            
            ctx.cgContext.setFillColor(UIColor.systemPink.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.systemPurple.cgColor)
            ctx.cgContext.setLineWidth(20)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    
    func drawCheckerBoard()
    {
        let renderer    = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
    }
}
