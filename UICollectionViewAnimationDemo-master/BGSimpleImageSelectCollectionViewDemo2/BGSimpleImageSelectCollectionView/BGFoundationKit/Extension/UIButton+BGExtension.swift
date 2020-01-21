//
//  UIButton+BGExtension.swift
//  BGPhotoPickerControllerDemo
//
//  Created by user on 15/10/15.
//  Copyright © 2015年 BG. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title:String, titleColor:UIColor, font: UIFont, textAlignment: NSTextAlignment = NSTextAlignment.center) {
        self.init(frame:CGRect.zero)
        self.setupButton(title, titleColor: titleColor, font: font, textAlignment: textAlignment)
    }
    
    convenience init(title:String, titleColor:UIColor, font: UIFont, backgroundColor: UIColor = UIColor.clear) {
        self.init(frame:CGRect.zero)
        self.setupButton(title, titleColor: titleColor, font: font, backgroundColor: backgroundColor, frame: CGRect.zero, buttonType: UIButtonType.custom)
    }
    
    convenience init(title:String, titleColor:UIColor, font: UIFont, frame: CGRect = CGRect.zero) {
        self.init(frame: frame)
        self.setupButton(title, titleColor: titleColor, font: font, backgroundColor: UIColor.clear, frame: frame, buttonType: UIButtonType.custom)
    }
    
    convenience init(title:String, titleColor:UIColor, font: UIFont, backgroundColor: UIColor = UIColor.clear, frame: CGRect = CGRect.zero, buttonType: UIButtonType) {
        self.init(frame:frame)
        self.setupButton(title, titleColor: titleColor, font: font, backgroundColor: backgroundColor, frame: frame, buttonType: buttonType)
    }
    
    fileprivate func setupButton(_ title:String, titleColor:UIColor, font: UIFont, textAlignment: NSTextAlignment = NSTextAlignment.center, backgroundColor: UIColor = UIColor.clear, frame: CGRect = CGRect.zero, buttonType: UIButtonType = UIButtonType.custom){
        
    }
}
