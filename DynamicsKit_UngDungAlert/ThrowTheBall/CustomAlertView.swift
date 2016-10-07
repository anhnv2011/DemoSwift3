//
//  CustomAlertView.swift
//  ThrowTheBall
//
//  Created by Tuuu on 8/16/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class CustomAlertView: UIViewController {

    var overlayView: UIView!
    var alertView: UIView!
    var animator: UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var snapBehavior : UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize the animator
        animator = UIDynamicAnimator(referenceView: view)
        
        // Create the dark background view and the alert view
        createOverlay()
        createAlert()
    }
    
    func createOverlay() {
        // Create a gray view and set its alpha to 0 so it isn't visible
        overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.gray
        overlayView.alpha = 0.0
        view.addSubview(overlayView)
    }
    
    func createAlert() {
        // Here the red alert view is created. It is created with rounded corners and given a shadow around it
        let alertWidth: CGFloat = 250
        let alertHeight: CGFloat = 150
        let buttonWidth: CGFloat = 40
        let alertViewFrame: CGRect = CGRect(x: 0, y: 0, width: alertWidth, height: alertHeight)
        alertView = UIView(frame: alertViewFrame)
        alertView.backgroundColor = UIColor.white
        alertView.alpha = 0.0
        alertView.layer.cornerRadius = 10;
        alertView.layer.shadowColor = UIColor.black.cgColor;
        alertView.layer.shadowOffset = CGSize(width: 0, height: 5);
        alertView.layer.shadowOpacity = 0.3;
        alertView.layer.shadowRadius = 10.0;
        
        // Create a button and set a listener on it for when it is tapped. Then the button is added to the alert view
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Dismiss.png"), for: UIControlState())
        button.backgroundColor = UIColor.clear
        button.frame = CGRect(x: alertWidth/2 - buttonWidth/2, y: -buttonWidth/2, width: buttonWidth, height: buttonWidth)
        
        button.addTarget(self, action: #selector(CustomAlertView.dismissAlert), for: UIControlEvents.touchUpInside)
        
        let rectLabel = CGRect(x: 0, y: button.frame.origin.y + button.frame.height, width: alertWidth, height: alertHeight - buttonWidth/2)
        let label = UILabel(frame: rectLabel)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Techmaster \n Xin Chao Cac Ban!"
        label.textAlignment = .center
        
        alertView.addSubview(label)
        alertView.addSubview(button)
        view.addSubview(alertView)
    }
    
    func showAlert() {
        // When the alert view is dismissed, I destroy it, so I check for this condition here
        // since if the Show Alert button is tapped again after dismissing, alertView will be nil
        // and so should be created again
        if (alertView == nil) {
            createAlert()
        }
        
        // I create the pan gesture recognizer here and not in ViewDidLoad() to
        // prevent the user moving the alert view on the screen before it is shown.
        // Remember, on load, the alert view is created but invisible to user, so you
        // don't want the user moving it around when they swipe or drag on the screen.
        createGestureRecognizer()
        
        animator.removeAllBehaviors()
        
        // Animate in the overlay
        UIView.animate(withDuration: 0.4, animations: {
            self.overlayView.alpha = 1.0
        }) 
        
        // Animate the alert view using UIKit Dynamics.
        alertView.alpha = 1.0
        
        let snapBehaviour: UISnapBehavior = UISnapBehavior(item: alertView, snapTo: view.center)
        animator.addBehavior(snapBehaviour)
    }
    
    func dismissAlert() {
        animator.removeAllBehaviors()

        UIView.animate(withDuration: 0.4, animations: {
            self.overlayView.alpha = 0.0
            self.alertView.alpha = 0.0
            }, completion: {
                (value: Bool) in
                self.alertView.removeFromSuperview()
                self.alertView = nil
        })
        
    }
    
    @IBAction func showAlertView(_ sender: UIButton) {
        showAlert()
    }
    
    func createGestureRecognizer() {
        let panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(CustomAlertView.handlePan(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    // This gets called when a pan gesture is recognized. It was set as the selector for the UIPanGestureRecognizer in the
    // createGestureRecognizer() function
    // We check for different states of the pan and do something different in each state
    // In Began, we create an attachment behaviour. We add an offset from the center to make the alert view twist in the
    // the direction of the pan
    // In Changed we set the attachment behaviour's anchor point to the location of the user's touch
    // When the user stops dragging (In Ended), we snap the alert view back to the view's center (which is where it was originally located)
    // When the user drags the view too far down, we dismiss the view
    // I check whether the alert view is not nil before taking action. This ensures that when the user dismisses the alert view
    // and drags on the screen, the app will not crash as it tries to move a view that hasn't been initialized.
    func handlePan(_ sender: UIPanGestureRecognizer) {
        
        if (alertView != nil) {
            let panLocationInView = sender.location(in: view)
            let panLocationInAlertView = sender.location(in: alertView)
            
            if sender.state == UIGestureRecognizerState.began {
                animator.removeAllBehaviors()
                
                let offset = UIOffsetMake(panLocationInAlertView.x - alertView.bounds.midX, panLocationInAlertView.y - alertView.bounds.midY);
                attachmentBehavior = UIAttachmentBehavior(item: alertView, offsetFromCenter: offset, attachedToAnchor: panLocationInView)
                
                animator.addBehavior(attachmentBehavior)
            }
            else if sender.state == UIGestureRecognizerState.changed {
                attachmentBehavior.anchorPoint = panLocationInView
            }
            else if sender.state == UIGestureRecognizerState.ended {
                animator.removeAllBehaviors()
                
                snapBehavior = UISnapBehavior(item: alertView, snapTo: view.center)
                animator.addBehavior(snapBehavior)
                
                if sender.translation(in: view).y > 100 {
                    dismissAlert()
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
