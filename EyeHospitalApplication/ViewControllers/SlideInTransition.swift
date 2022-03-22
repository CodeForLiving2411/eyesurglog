//
//  SlideInTransition.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 07/02/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit

class SlideInTransition : NSObject , UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 3.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      guard  let toViewController = transitionContext.viewController(forKey: .to),
        let fromViewController = transitionContext.viewController(forKey: .from) else {return }
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHieght = fromViewController.view.bounds.height
        
        if isPresenting {
             // Add Menu View  controller to container
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height:finalHieght)
        }
        let transform = {
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        let identity = {
            fromViewController.view.transform = .identity
        }
        // Animation of the transition 
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform() : identity()
            
        }) { (_) in
            transitionContext.completeTransition(isCancelled)
            
        }
    
        
        
        
        
    }
    
    
    var isPresenting = false
    
    
}
