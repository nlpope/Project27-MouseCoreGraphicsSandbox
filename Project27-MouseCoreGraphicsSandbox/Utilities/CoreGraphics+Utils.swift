//  File: CoreGraphics+Utils.swift
//  Project: Project27-MouseCoreGraphicsSandbox
//  Created by: Noah Pope on 3/31/25.

import UIKit

public func rotateAddTranslateReset(_ ctx: UIGraphicsImageRendererContext,
                   atAngle rotationAngle: CGFloat,
                   lineLength: CGFloat)
{
    ctx.cgContext.rotate(by: rotationAngle)
    ctx.cgContext.addLine(to: CGPoint(x: lineLength, y: 0))
    
    // focus here for midpoint translation on T (if midpoint == true)
    ctx.cgContext.translateBy(x: lineLength, y: 0)
    
    ctx.cgContext.rotate(by: -rotationAngle)
}
