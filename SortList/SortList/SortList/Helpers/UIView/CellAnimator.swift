//
//  CellAnimator.swift
//  CellAnimator
//
//  Created by William Archimede on 29/08/2014.
//  Copyright (c) 2014 HoodBrains. All rights reserved.
//

import UIKit
import QuartzCore

public class CellAnimator {
    
    public static let TransformTipIn = { (layer: CALayer) -> CATransform3D in
        let rotationDegrees: CGFloat = -15.0
        let rotationRadians: CGFloat = rotationDegrees * (CGFloat(M_PI)/180.0)
        let offset = CGPoint(x: -20, y: -20)
        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, rotationRadians, 0.0, 0.0, 1.0)
        transform = CATransform3DTranslate(transform, offset.x, offset.y, 0.0)
        
        return transform
    }
    
    public static let TransformCurl = { (layer: CALayer) -> CATransform3D in
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -500
        transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI)/2.0, 0.0, 1.0, 0.0)
        transform = CATransform3DTranslate(transform, layer.bounds.size.width/2.0, 0.0, 0.0)
        
        return transform
    }
    
    public static let TransformFan = { (layer: CALayer) -> CATransform3D in
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, -CGFloat(M_PI)/2.0, 0.0, 0.0, 1.0)
        transform = CATransform3DTranslate(transform, layer.bounds.size.width/2.0, 0.0, 0.0)
        return transform
    }
    
    public static let TransformFlip = { (layer: CALayer) -> CATransform3D in
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0.0, layer.bounds.size.height/2.0, 0.0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI)/2.0, 1.0, 0.0, 0.0)
        transform = CATransform3DTranslate(transform, 0.0, layer.bounds.size.height/2.0, 0.0)
        return transform
    }
    
    public static let TransformHelix = { (layer: CALayer) -> CATransform3D in
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0.0, layer.bounds.size.height/2.0, 0.0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI), 0.0, 1.0, 0.0)
        transform = CATransform3DTranslate(transform, 0.0, -layer.bounds.size.height/2.0, 0.0)
        return transform
    }
    
    public static let TransformTilt = { (layer: CALayer) -> CATransform3D in
        var transform = CATransform3DIdentity
        transform = CATransform3DScale(transform, 0.8, 0.8, 0.8)
        return transform
    }
    
    public static let TransformWave = { (layer: CALayer) -> CATransform3D in
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0, 0.0, 0.0)
        return transform
    }
    
    public class func animateCell(cell: UITableViewCell, withTransform transform: (CALayer) -> CATransform3D, andDuration duration: NSTimeInterval) {
        
        let view = cell.contentView
        view.layer.transform = transform(cell.layer)
        view.layer.opacity = 0.8
        
        UIView.animateWithDuration(duration) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }
    }
}

extension CellAnimator{
    // original: http://www.thinkandbuild.it/animating-uitableview-cells/
    
    public static let TransformWave2 = { (layer: CALayer) -> CATransform3D in
        var transform = CATransform3DIdentity
        
        transform = CATransform3DRotate(transform, 90.0*CGFloat(M_PI)/180, 0.0, 0.7, 0.4);
        transform.m34 = 1.0 / -600;
        return transform
    }
    
    public class func animateCell(cell: UITableViewCell) {
        
        let view = cell.contentView
        view.layer.shadowColor = UIColor.blackColor().CGColor;
        view.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        
        view.layer.transform = TransformWave2(cell.layer)
        view.layer.anchorPoint = CGPointMake(0, 0.5);
        
        UIView.animateWithDuration(0.8) {
            view.layer.transform = CATransform3DIdentity
            cell.alpha = 1;
            view.layer.shadowOffset = CGSizeMake(0, 0);
            
        }
    }
    
    
}

