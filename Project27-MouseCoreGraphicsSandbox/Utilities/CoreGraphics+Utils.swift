//  File: CoreGraphics+Utils.swift
//  Project: Project27-MouseCoreGraphicsSandbox
//  Created by: Noah Pope on 3/31/25.

import UIKit

enum RotationAngles {
    static let zero: CGFloat = 0.0
    static let ninety: CGFloat = .pi / 2
    static let seventyFive: CGFloat = 1.309
}

public func rotateAddTranslateReset(_ ctx: UIGraphicsImageRendererContext,
                   atAngle rotationAngle: CGFloat,
                   backTrackToMidPoint: Bool,
                   lineLength: CGFloat)
{
    
    if backTrackToMidPoint {
        ctx.cgContext.translateBy(x: -lineLength / 2, y: 0)
        ctx.cgContext.move(to: CGPoint(x: 0, y: 0))
        ctx.cgContext.rotate(by: rotationAngle)
        ctx.cgContext.addLine(to: CGPoint(x: lineLength, y: 0))
        ctx.cgContext.rotate(by: -rotationAngle)
        ctx.cgContext.translateBy(x: lineLength / 2, y: 0)
    } else {
        /** already translated in the HomeVC **/
        ctx.cgContext.move(to: CGPoint(x: 0, y: 0))
        ctx.cgContext.rotate(by: rotationAngle)
        ctx.cgContext.addLine(to: CGPoint(x: lineLength, y: 0))
        ctx.cgContext.translateBy(x: lineLength, y: 0)
        ctx.cgContext.rotate(by: -rotationAngle)
    }
}
