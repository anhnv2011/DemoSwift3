//
//  ViewController.swift
//  NodeIOS
//
//  Created by CanDang on 1/2/16.
//  Copyright © 2016 CanDang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var mainImageView: UIImageView!
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var baseImage = UIImage()
    var pixel: Int = 5
    let imgColors = ["Black", "Grey", "Red", "Blue", "LightBlue", "DarkGreen", "LightGreen", "Brown", "DarkOrange", "Yellow"]
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func reset(_ sender: AnyObject) {
        mainImageView.image = baseImage
    }
    @IBAction func Save(_ sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(mainImageView.image!, self, nil, nil)
    }
    @IBAction func Album(_ sender: UIButton) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imgPicker, animated: true, completion: nil)
    }
    //Image Picker Controller Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage:UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage
        {
            baseImage = pickedImage
            mainImageView.image = baseImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonClick(_ sender: AnyObject) {
        let index = sender.tag
        switch (index!)
        {
            case 0: pixel = 5
            case 1: pixel = 10
            case 2: pixel = 30
            case 3:(red, green, blue) = colors[10]
            default: break
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: view)
        }
    }
    func drawLineFrom(_ fromPoint: CGPoint, toPoint: CGPoint) {
        
        // 1
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: mainImageView.frame.size.width, height: mainImageView.frame.size.height))
        
        // 2
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        // 3
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(CGFloat(pixel))
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        // 4
        context?.strokePath()
        
        // 5
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        mainImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: mainImageView)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            
            // 7
            lastPoint = currentPoint
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return colors.count - 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellColection", for: indexPath) as! PhotoEffectColectionCell
        cell.filteredImageView.image = UIImage(named: imgColors[(indexPath as NSIndexPath).item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        (red, green, blue) = colors[(indexPath as NSIndexPath).item]
    }

    


}

