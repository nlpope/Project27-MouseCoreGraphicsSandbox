//  File: CoreGraphics+Utils.swift
//  Project: Project27-MouseCoreGraphicsSandbox
//  Created by: Noah Pope on 3/31/25.

import UIKit

//-------------------------------------//
// MARK: ROTATION ANGLES
enum RotationAngles
{
    static let zero: CGFloat        = 0.0
    static let seventyFive: CGFloat = 1.309
    static let fortyFive: CGFloat   = .pi / 4
    static let ninety: CGFloat      = .pi / 2
}

//-------------------------------------//
// MARK: INDIVIDUAL LETTER LOGIC

enum CGLetters
{
    /** be sure to end at top right of letter at every case*/
    static func drawT(inContext ctx: UIGraphicsImageRendererContext, lineLength: CGFloat)
    {
        rotateAddTranslateReset(ctx, atAngle: RotationAngles.zero, backTrackToMidPoint: false, lineLength: lineLength, snapBackToOrigin: false)
        rotateAddTranslateReset(ctx, atAngle: RotationAngles.ninety, backTrackToMidPoint: true, lineLength: lineLength, snapBackToOrigin: false)
    }
    
    
    static func drawW(inContext ctx: UIGraphicsImageRendererContext, lineLength: CGFloat)
    {
        rotateAddTranslateReset(ctx, atAngle: RotationAngles.seventyFive, backTrackToMidPoint: false, lineLength: lineLength, snapBackToOrigin: false)
        rotateAddTranslateReset(ctx, atAngle: -RotationAngles.seventyFive, backTrackToMidPoint: false, lineLength: lineLength / 2, snapBackToOrigin: false)
        rotateAddTranslateReset(ctx, atAngle: RotationAngles.seventyFive, backTrackToMidPoint: false, lineLength: lineLength / 2, snapBackToOrigin: false)
        rotateAddTranslateReset(ctx, atAngle: -RotationAngles.seventyFive, backTrackToMidPoint: false, lineLength: lineLength, snapBackToOrigin: false)
    }
    
    
    static func drawI(inContext ctx: UIGraphicsImageRendererContext, lineLength: CGFloat)
    {
        rotateAddTranslateReset(ctx, atAngle: RotationAngles.ninety, backTrackToMidPoint: false, lineLength: lineLength, snapBackToOrigin: true)

    }
    
    
    static func drawN(inContext ctx: UIGraphicsImageRendererContext, lineLength: CGFloat)
    {
        rotateAddTranslateReset(ctx, atAngle: RotationAngles.ninety, backTrackToMidPoint: false, lineLength: lineLength, snapBackToOrigin: true)
        rotateAddTranslateReset(ctx, atAngle: RotationAngles.fortyFive, backTrackToMidPoint: false, lineLength: lineLength * 1.35, snapBackToOrigin: false)
        rotateAddTranslateReset(ctx, atAngle: -RotationAngles.ninety, backTrackToMidPoint: false, lineLength: lineLength, snapBackToOrigin: false)
    }
}

//-------------------------------------//
// MARK: MAIN 'RATR' METHOD

public func rotateAddTranslateReset(_ ctx: UIGraphicsImageRendererContext,
                                    atAngle rotationAngle: CGFloat,
                                    backTrackToMidPoint: Bool,
                                    lineLength: CGFloat,
                                    snapBackToOrigin: Bool)
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
        if !snapBackToOrigin { ctx.cgContext.translateBy(x: lineLength, y: 0) }
        ctx.cgContext.rotate(by: -rotationAngle)
    }
}
