//
//  BackgroundView.swift
//  Weather Now
//
//  Created by Scott Baumbich on 11/3/15.
//  Copyright © 2015 Scott Baumbich. All rights reserved.
//

import UIKit

class BackgroundView: UIView {

    override func drawRect(rect: CGRect) {

        // Background View
        
        //// Color Declarations
        let lightBlue: UIColor = UIColor(red: 0.216, green: 0.420, blue: 0.678, alpha: 1.000)
        let darkBlue: UIColor = UIColor(red: 0.030, green: 0.126, blue: 0.302, alpha: 1.000)
        
        let context = UIGraphicsGetCurrentContext()
        
        //// Gradient Declarations
        let purpleGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [lightBlue.CGColor, darkBlue.CGColor], [0, 1])
        
        //// Background Drawing
        let backgroundPath = UIBezierPath(rect: CGRectMake(0, 0, self.frame.width, self.frame.height))
        CGContextSaveGState(context)
        backgroundPath.addClip()
        CGContextDrawLinearGradient(context, purpleGradient,
            CGPointMake(160, 0),
            CGPointMake(160, 568),
            [.DrawsBeforeStartLocation, .DrawsAfterEndLocation])
        CGContextRestoreGState(context)
        
    }
}
