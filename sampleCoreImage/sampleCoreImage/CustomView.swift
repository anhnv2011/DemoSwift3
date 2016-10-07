//
//  CustomView.swift
//  sampleCoreImage
//
//  Created by CanDang on 12/30/15.
//  Copyright © 2015 CanDang. All rights reserved.
//

import UIKit
protocol ParameterAdjustmentDelegate {
    func parameterValueDidChange(_ param: ObjectPara)
}
class CustomView: UIView {
    @IBOutlet var view: UIView!

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var slider: UISlider!
    var parameter: ObjectPara!
    var delegate: ParameterAdjustmentDelegate?
    init(frame: CGRect, parameter: ObjectPara) {
        super.init(frame: frame)
        self.parameter = parameter
        loadViewFromNib()
        addValue()
    }
    func addValue() {
        slider.minimumValue = parameter.minimumValue!
        slider.maximumValue = parameter.maximumValue!
        slider.value = parameter.currentValue
        
        
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        descriptionLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
        descriptionLabel.text = parameter.name
        
        
        
        value.font = UIFont.systemFont(ofSize: 14)
        value.textColor = UIColor(white: 0.9, alpha: 1.0)
        value.textAlignment = .right
        value.text = slider.value.description
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadViewFromNib()
    }
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view);
        
    }
    @IBAction func sliderValueDidChange(_ sender: AnyObject?) {
        value.text = String(format: "%0.2f", slider.value)
    }
    
    @IBAction func sliderTouchUpInside(_ sender: AnyObject?) {
        if delegate != nil {
            delegate!.parameterValueDidChange(ObjectPara(key: parameter.key, value: slider.value))
        }
    }
}
