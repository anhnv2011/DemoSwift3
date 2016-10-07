//
//  FilterView.swift
//  sampleCoreImage
//
//  Created by CanDang on 12/30/15.
//  Copyright © 2015 CanDang. All rights reserved.
//

import UIKit
class FilterView: UIViewController, ParameterAdjustmentDelegate {
    let kSliderHeight: CGFloat = 37
    let kSliderMarginY: CGFloat = 2
    var add = false
    var nameFilter: String?
    var image: UIImage?
    var filter: CIFilter!
    
    @IBOutlet weak var imgFilterView: ViewFilter!
    @IBOutlet weak var subView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgFilterView.image = image!
        let ciImage = CIImage(image: imgFilterView.image!)
        filter.setValue(ciImage, forKey: kCIInputImageKey)
    }
    override func viewDidLayoutSubviews() {
        if (!add)
        {
            add = true
            let arrPara = filterParameterDescriptors()
            let heightSlider = (self.subView.frame.height - kSliderMarginY * CGFloat(arrPara.count)) / CGFloat(arrPara.count)
            var yOffset: CGFloat = 0
            for obj in arrPara
            {
                let view = CustomView(frame: CGRect(x: 0, y: self.subView.frame.origin.y + yOffset + kSliderMarginY, width: self.view.frame.size.width, height: heightSlider), parameter: obj)
                view.parameter = obj
                view.delegate = self
                yOffset += (kSliderMarginY + heightSlider)
                self.view.addSubview(view)
            }
        }
    }
    func filterParameterDescriptors() -> [ObjectPara] {
        var arrPara = [ObjectPara]()
        for inputName in filter.inputKeys
        {
            if (inputName != "inputImage")
            {
                let attributes = filter.attributes
                let attribute = attributes[inputName] as! [String : AnyObject]
                let minValue = attribute[kCIAttributeSliderMin] as! Float
                let maxValue = attribute[kCIAttributeSliderMax] as! Float
                let defaultValue = attribute[kCIAttributeDefault] as! Float
                arrPara.append(ObjectPara(name: inputName, key: inputName, minimumValue: minValue, maximumValue: maxValue, currentValue: defaultValue))
            }
        }
        return arrPara
        
    }
    func parameterValueDidChange(_ parameter: ObjectPara) {
        filter.setValue(parameter.currentValue, forKey: parameter.key)
        let citemp = imgFilterView.getImageFilter(filter)
        imgFilterView.image = citemp
        
    }
    
    @IBAction func saveImg(_ sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(imgFilterView.image!, self, nil, nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
