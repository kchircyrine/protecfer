//
//  UIView+Animations.swift
//  ThiagoBernardes
//  Copyright © 2016 TB. All rights reserved.
//
import UIKit

enum WipeDirection {
    
    case bottomToTop ,leftToRight, topToBottom, rightToLeft
    
}

enum RotationDegree {
    
    case degree360, degree180, degree90, degree45
}

enum RotationType {
    
    case clockWize, unClockWize
}

extension UIView {
    
    func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}, finalAlpha : CGFloat = 1.0) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions(), animations: {
            self.alpha = finalAlpha
            }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}, finalAlpha : CGFloat = 0.0) {
        
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions(), animations: {
            self.alpha = finalAlpha
            }, completion: completion)
    }
    
    func slideInFromLeft(_ duration: TimeInterval = 1.0, completionDelegate: CAAnimationDelegate? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: CAAnimationDelegate = completionDelegate {
            slideInFromLeftTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionPush
        slideInFromLeftTransition.subtype = kCATransitionFromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    func rotateInDiraction(
        _ direction: RotationType,andDegrees
        degrees: RotationDegree,
        duration: CFTimeInterval = 1.0,
        delay: CFTimeInterval = 1.0,
        completionBlock: (() -> Void)? = {}) {
        
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: {
            
            var rotationConstant = CGFloat(M_PI * 2.0)
            
            switch degrees {
            case .degree360:
                rotationConstant = CGFloat(M_PI * 2.0)
            case .degree180:
                rotationConstant = CGFloat(M_PI )
            case .degree90:
                rotationConstant = CGFloat(M_PI_2)
            case .degree45:
                rotationConstant = CGFloat(M_PI_4)
            }
            
            switch direction {
            case .clockWize:
                rotationConstant = 1 * rotationConstant
            case .unClockWize:
                rotationConstant = -1 * rotationConstant
                
            }
            
            self.transform = CGAffineTransform(rotationAngle: rotationConstant)
        
        }) { (finished: Bool) in
            if completionBlock != nil {
                completionBlock!()

            }
        }
        
    }
    
    func wipeInDirection(
        _ wipeDirection: WipeDirection,
        isOutAnimation: Bool,
        duration: TimeInterval,
        percentageVertical: CGFloat = 1.0,
        percentageHorizontal: CGFloat = 1.0,
        timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
        completionDelegate: CAAnimationDelegate? = nil) {
        
        var direction = CGPoint(x: 1, y: 0)
        
        switch wipeDirection {
        case .bottomToTop:
            direction = CGPoint(x: 0, y: -1)
        case .leftToRight:
            direction = CGPoint(x: -1, y: 0)
        case .topToBottom:
            direction = CGPoint(x: 0, y: 1)
        case .rightToLeft:
            direction = CGPoint(x: 1, y: 0)
        }
        
        let contentView = self
        
        var startRootViewBounds = self.bounds
        
        //        self.addSubview(contentView)
        //        self.backgroundColor = UIColor.clearColor()
        
        var endingContentsRect: CGRect = CGRect(x: 0, y: 0, width: 1 - abs(direction.x), height: 1 - abs(direction.y))
        
        
        if direction.x < 0 {
            endingContentsRect.origin.x = 1
        }
        if direction.y < 0 {
            endingContentsRect.origin.y = 1
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        //        contentView.layer.anchorPoint = CGPointMake(0.5, 0.4)
        let useLowerRight: Bool = (direction.x + direction.y < 0)
        if useLowerRight {
            
            setAnchorPoint(CGPoint(x: 1, y: 1), forView: contentView)
        }
        else {
            
            setAnchorPoint(CGPoint.zero, forView: contentView)
            
            
        }
        
        
        var startContentLayerRect = contentView.bounds
        var startContentLayerBounds = contentView.layer.bounds
        var endingContentsBounds = endingContentsRect
        
        if !isOutAnimation {
            
            let aux = startRootViewBounds
            startRootViewBounds = endingContentsBounds
            endingContentsBounds = aux
            
        }
        
        let t: CGAffineTransform = CGAffineTransform(scaleX: startRootViewBounds.width,y: startRootViewBounds.height)
        var endingBounds: CGRect = endingContentsBounds.applying(t)
    
        
        //Apply percentage
        startContentLayerRect.size = CGSize(
            width: startContentLayerRect.width * percentageHorizontal,
            height: startContentLayerRect.height * percentageVertical)
        endingContentsRect.size = CGSize(
            width: endingContentsRect.width * percentageHorizontal,
            height: endingContentsRect.height * percentageVertical)
        startContentLayerBounds.size = CGSize(
            width: startContentLayerBounds.width * percentageHorizontal,
            height: startContentLayerBounds.height * percentageVertical)
        endingBounds.size = CGSize(
            width: endingBounds.width * percentageHorizontal,
            height: endingBounds.height * percentageVertical)
        
        if !isOutAnimation {
            var aux = startContentLayerRect
            startContentLayerRect = endingContentsRect
            endingContentsRect = aux
            
            aux = startContentLayerBounds
            startContentLayerBounds = endingBounds
            endingBounds = aux
        }
        
        
        let contentsRectAnim: CABasicAnimation = CABasicAnimation(keyPath: "contentsRect")
        contentsRectAnim.fromValue = NSValue(cgRect: startContentLayerRect)
        contentsRectAnim.toValue = NSValue(cgRect: endingContentsRect)
        
        let boundsAnim: CABasicAnimation = CABasicAnimation(keyPath: "bounds")
        boundsAnim.fromValue = NSValue(cgRect: startContentLayerBounds)
        boundsAnim.toValue = NSValue(cgRect: CGRect(x: endingBounds.origin.x, y: endingBounds.origin.y, width: endingBounds.width, height: endingBounds.height))
        let animations: CAAnimationGroup = CAAnimationGroup()
        if let delegate: CAAnimationDelegate = completionDelegate {
            animations.delegate = delegate
        }
        animations.duration = duration
        animations.timingFunction = timingFunction
        animations.animations = [contentsRectAnim, boundsAnim]
        contentView.layer.add(animations, forKey: "wipeOut")
        contentView.layer.contentsRect = endingContentsRect
        contentView.layer.bounds = endingBounds
        
    }
    
    
    func clockWiseWipe(
        _ duration: CFTimeInterval,
        timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
        completionDelegate: CAAnimationDelegate? = nil, theBlock : (() -> Void)?) {
        
        self.isHidden = false
        
        let maskLayer = CAShapeLayer()
        let maskHeight = self.layer.bounds.size.height
        let maskWidth = self.layer.bounds.size.width
        
        let centerPoint = CGPoint(x: maskWidth/2, y: maskHeight/2)
        
        let radius = CGFloat(sqrtf(Float(maskWidth) * Float(maskWidth) + Float(maskHeight) * Float(maskHeight))/2)
        
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = UIColor.black.cgColor
        
        maskLayer.lineWidth = CGFloat(radius)
        
        let arcPath = CGMutablePath()
        
        
        arcPath.move(to: CGPoint(x: centerPoint.x, y: centerPoint.y - radius/2), transform: CGAffineTransform.identity)
 
        arcPath.addArc(center: CGPoint(x: centerPoint.x,
                                       y: centerPoint.y),
                       radius: radius/2,
                       startAngle: 3.0 * CGFloat(M_PI/2),
                       endAngle: CGFloat(-M_PI/2),
                       clockwise: true, transform: CGAffineTransform.identity)

        
        maskLayer.path = arcPath
        
        maskLayer.strokeEnd = 0.0
        
        self.layer.mask = maskLayer
        
        self.layer.mask?.frame = self.layer.bounds
        
        let swipe = CABasicAnimation(keyPath: "strokeEnd")
        
        swipe.duration = duration
        
        if let delegate: CAAnimationDelegate = completionDelegate {
            swipe.delegate = delegate
        }
        swipe.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        swipe.fillMode = kCAFillModeForwards
        swipe.isRemovedOnCompletion = false
        swipe.autoreverses = false
    
        swipe.toValue = NSNumber(value: 1 as Float)
        
        maskLayer.add(swipe, forKey: "strokeEnd")
        
    }
    
    func bouncingAnimation(_ isZoomIn: Bool = true,
                           duration: TimeInterval = 1.0,
                           delay: TimeInterval = 0.0,
                           completion: ((Bool) -> Void) = {_ in},
                           finalAlpha : CGFloat = 1.0 ,
                           animationOptions: UIViewAnimationOptions = []) {
        
        var initTransform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9);
        var transitionTransform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1);
        var finalTransform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9);
        
        if !isZoomIn {
            initTransform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1);
            transitionTransform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9);
            finalTransform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9);
        }
        
 
        UIView.animate(withDuration: duration/1.5, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: animationOptions, animations: {
            
            self.transform = initTransform
            
            }, completion: { (finished :Bool) -> Void in
                
                UIView.animate(withDuration: duration/1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: animationOptions, animations: {
                    
                    self.transform = transitionTransform
                    
                    }, completion: { (finished :Bool) -> Void in
                        
                        UIView.animate(withDuration: duration/2, delay: 0,  options: animationOptions, animations: {
                            
                            self.transform = finalTransform
                            
                            }, completion: { (finished :Bool) -> Void in
                                
                                UIView.animate(withDuration: duration/2, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.5, options: animationOptions, animations: {
                                    
                                    self.transform = CGAffineTransform.identity;
                                    
                                    }, completion: { (finished :Bool) -> Void in
                                        
                                        
                                })
                                
                        })
                        
                } )
        })
    }
    
    func shakeAnimation(_ duration : TimeInterval = 7/100, repeatCount : Float = 3, intensity: CGFloat = 5.0,
        completionDelegate: CAAnimationDelegate? = nil) {
        
        let anim = CAKeyframeAnimation( keyPath:"transform" )
        anim.values = [
            NSValue( caTransform3D:CATransform3DMakeTranslation(-intensity, 0, 0 ) ),
            NSValue( caTransform3D:CATransform3DMakeTranslation( intensity, 0, 0 ) )
        ]
        anim.autoreverses = true
        anim.repeatCount = repeatCount
        anim.duration = duration
        if let delegate: CAAnimationDelegate = completionDelegate {
            anim.delegate = delegate
        }
        anim.setValue("shakeAnimation", forKey: "identifier")
        self.layer.add( anim, forKey:"shakeAnimation" )
        
    }
    
    //MARK: - Helpers
    func setAnchorPoint(_ anchorPoint: CGPoint, forView view: UIView) {
        
        var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.translatesAutoresizingMaskIntoConstraints = true     // Added to deal with auto layout constraints
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
    
}
