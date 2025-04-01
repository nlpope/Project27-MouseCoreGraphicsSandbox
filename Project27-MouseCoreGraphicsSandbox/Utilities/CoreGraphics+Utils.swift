//  File: CoreGraphics+Utils.swift
//  Project: Project27-MouseCoreGraphicsSandbox
//  Created by: Noah Pope on 3/31/25.

import UIKit

public func rotateAddTranslateReset(_ ctx: UIGraphicsImageRendererContext,
                   atAngle rotationAngle: CGFloat,
                   backTrackToMidPoint: Bool,
                   lineLength: CGFloat)
{
//    ctx.cgContext.rotate(by: rotationAngle)
//    ctx.cgContext.addLine(to: CGPoint(x: lineLength, y: 0))

    if backTrackToMidPoint {
        ctx.cgContext.translateBy(x: -lineLength / 2, y: 0)
        ctx.cgContext.rotate(by: rotationAngle)
        ctx.cgContext.addLine(to: CGPoint(x: lineLength, y: 0))

    }
    else {
        ctx.cgContext.rotate(by: rotationAngle)
        ctx.cgContext.addLine(to: CGPoint(x: lineLength, y: 0))
        ctx.cgContext.translateBy(x: lineLength, y: 0)
        
    }
    
    ctx.cgContext.rotate(by: -rotationAngle)
}


public func snapToOriginAndTravelToNewLetterStartPoint(inContext ctx: UIGraphicsImageRendererContext)
{
}
