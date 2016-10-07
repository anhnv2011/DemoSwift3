//
//  LineView.swift
//  DynamicsKitDemo
//
//  Created by Trung on 8/4/14.
//  Copyright (c) 2014 vn.Techmsater. All rights reserved.
//

import UIKit
import QuartzCore
class LineView: UIView {
    var attachmentPointView: UIView!
    var attachedView: UIView!
    var attachmentOffset: CGPoint!
    var attachmentDecorationLayers: NSMutableArray!
    var arrowView: UIImageView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func drawMagnitudeVectorWithLength(_ length:CGFloat, angle:CGFloat, color:UIColor, temporaru:Bool){
        if(self.arrowView == nil) {
            let arrowImage = UIImage(named:"Arrow")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            let arrowImageView = UIImageView(image: arrowImage)
            arrowImageView.bounds = CGRect(x: 0, y: 0, width: arrowImage.size.width, height: arrowImage.size.height)
            arrowImageView.contentMode = UIViewContentMode.right
            arrowImageView.clipsToBounds = true
            arrowImageView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
            
            self.addSubview(arrowImageView)
            self.sendSubview(toBack: arrowImageView)
            self.arrowView = arrowImageView
        }
    
        self.arrowView.bounds = CGRect(x: 0, y: 0, width: length, height: self.arrowView.bounds.size.height)
        self.arrowView.transform = CGAffineTransform(rotationAngle: angle)
        self.arrowView.tintColor = color
        self.arrowView.alpha = 1
        
        if(temporaru){
            UIView.animate(withDuration: 1.0, animations:{
                self.arrowView.alpha = 0
            })
        }
    }
    
    func trackAndDrawAttachmentFromView(_ attachmentPointView:UIView, attachedView:UIView, attachmentOffset:CGPoint){
        if(self.attachmentDecorationLayers == nil) {
            //First time initialization
            self.attachmentDecorationLayers = NSMutableArray(capacity: 4)
            for i in 0..<4 {
                let imageName = "DashStyle\((i%3)+1)"
                
                let dashImage = UIImage(named: imageName)  //Tạo ra 3 ảnh dash line
                let dashLayer = CALayer()
                dashLayer.contents = dashImage!.cgImage
                dashLayer.bounds = CGRect(x: 0, y: 0, width: dashImage!.size.width, height: dashImage!.size.height)
                dashLayer.anchorPoint = CGPoint(x: 0.5, y: 0)
                
                //self.layer.insertSublayer(dashLayer, atIndex: 0)
                self.layer.addSublayer(dashLayer)
                self.attachmentDecorationLayers.add(dashLayer)
            }
        }
        // A word about performance
        // Trackin changes to the properties of any id<UIDynamicItem> involved in
        // a simulator incurs a performance cost. You will receive a callback
        // during each step in the simulator in which the tracked item is not at rest/
        // You should therefore strive to make your callback code as efficient as possible.
        
        self.attachmentPointView = attachmentPointView
        self.attachedView = attachedView
        self.attachmentOffset = attachmentOffset
        
        /*
        Đoạn code này gây lỗi
        self.attachmentPointView.removeObserver(self, forKeyPath: "center")
        self.attachedView.removeObserver(self, forKeyPath: "center")*/
        
        // Observe the "center" property of both views to know when they move
        self.attachmentPointView.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.new, context: nil)
        self.attachedView.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.new, context: nil)
        
        self.setNeedsLayout()
        
    }
    
    //_____________
    
    override func layoutSubviews(){
        
        super.layoutSubviews()
        if (self.arrowView != nil ) {
            self.arrowView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        }
        
        
        if(self.attachmentDecorationLayers != nil){
            // Here we adjust the line dash pattern visualizing the attachment 
            // between attachmentPoint and attachedView to account for a change
            // in the position of either
            
            let maxDashes = self.attachmentDecorationLayers.count
            
            var attachmentPointViewCenter = CGPoint(x: self.attachmentPointView.bounds.size.width/2, y: self.attachmentPointView.bounds.size.height/2)
            attachmentPointViewCenter = self.attachmentPointView.convert(attachmentPointViewCenter, to: self)
            
            var attachedViewAttachmentPoint = CGPoint(x: self.attachedView.bounds.size.width/2 + self.attachmentOffset.x, y: self.attachedView.bounds.size.height/2 + self.attachmentOffset.y)
            attachedViewAttachmentPoint = self.attachedView.convert(attachedViewAttachmentPoint, to: self)
            
            
            
            let distance:CGFloat = CGFloat(sqrt(powf(Float(attachedViewAttachmentPoint.x) - Float(attachmentPointViewCenter.x), 2.0) + powf(Float(attachedViewAttachmentPoint.y) - Float(attachmentPointViewCenter.y), 2.0)))
            
            
            let angle:CGFloat = atan2(CGFloat( attachedViewAttachmentPoint.y - attachmentPointViewCenter.y), CGFloat(attachedViewAttachmentPoint.x - attachmentPointViewCenter.x))
            
            var requiredDashes = 0
            var d:CGFloat = 0.0
            
            // Depending on the distance betweeen the two views, a smaller number of 
            // dashes may be needed to adequately visualize the attachment. Starting with the distance of 0, we add the length of each dash ulti we exceed "distance" computed previosly or we use the maximum number of allowed dashes
            
            while ( requiredDashes < maxDashes){
                
                let dashLayer:CALayer =  self.attachmentDecorationLayers[requiredDashes] as! CALayer
                if(d + CGFloat(dashLayer.bounds.size.height) < distance){
                    d += dashLayer.bounds.size.height
                    dashLayer.isHidden = false
                    requiredDashes += 1
                    
                }else {
                    break
                }
            }
            
            // Based on the total length of the dashes we previously determined were
            // necessary to visualize the attachment, determine the spacing between each dash
            let a:CGFloat = distance - d
            let b:CGFloat = CGFloat(requiredDashes + 1)
            
            let dashSpacing:CGFloat = a / b
            
            // Hide the excess dashes
            for i in requiredDashes..<maxDashes {
                 (self.attachmentDecorationLayers[i] as! CALayer).isHidden = true
            }
            
            //Disable any animations. The changes must take full effect immediately
            CATransaction.begin()
            CATransaction.setAnimationDuration(0)
            
            // Each dash layer is positioned by altering its affineTransform.
            // We combine the position of rotation into an affine transformation matrix that 
            // is assigned to each dash
            
            
            var transform:CGAffineTransform = CGAffineTransform(translationX: attachmentPointViewCenter.x, y: attachmentPointViewCenter.y)
            transform = transform.rotated(by: angle - CGFloat(M_PI/2))
            
            for drawnDashes in 0 ..< requiredDashes{
                let dashLayer = self.attachmentDecorationLayers[drawnDashes] as! CALayer
                
                transform = transform.translatedBy(x: 0, y: dashSpacing)
                dashLayer.setAffineTransform(transform)
                transform = transform.translatedBy(x: 0, y: dashLayer.bounds.size.height)
            }
            CATransaction.commit()
        }
    }
    
    
    //____________________
    
     override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(object as! UIView == self.attachmentPointView || object as! UIView == self.attachedView){
            self.setNeedsLayout()
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }   
    }

    

    
    deinit{
        if(self.attachmentPointView != nil){
            self.attachmentPointView.removeObserver(self, forKeyPath: "center")
        }
        if(self.attachedView != nil){
            self.attachedView.removeObserver(self, forKeyPath: "center")
        }
        
    }
    
}
