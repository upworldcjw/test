//
//  BGBaseViewController.swift
//  BGPhotoPickerControllerDemo
//
//  Created by user on 15/10/14.
//  Copyright © 2015年 BG. All rights reserved.
//

import UIKit

enum BGNavigationBarStatus: Int {
    /** 不透明 */
    case opaque
    /** 半透明导航栏，透明度为0.3 */
    case translucent
    /** 完全透明 */
    case transparent
    /** 隐藏导航栏 */
    case hide
}

//私有常量
private let kNavigationBarStatusKey = "kNavigationBarStatusKey"

class BGBaseViewController: UIViewController {
    //MARK: - property
    var navigationBarStatus: BGNavigationBarStatus
    /** 是否默认显示左边返回按钮 */
    fileprivate var isShowLeftBackButton: Bool = true
    var showLeftBackButton: Bool {
        get {
            return isShowLeftBackButton
        }
        set (newValue) {
            isShowLeftBackButton = newValue
            if self.isViewLoaded {
                self.configureNavigationItem()
            }
        }
    }
    
    //MARK: - init method
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.navigationBarStatus = BGNavigationBarStatus.opaque
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // MARK: - NSCoding protocol method
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.navigationBarStatus.rawValue, forKey: kNavigationBarStatusKey)
        super.encode(with: aCoder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.navigationBarStatus = BGNavigationBarStatus.opaque
        super.init(coder: aDecoder)
    }
    
    // MARK: - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    // MARK: - navigation bar, item, title
    func configureNavigationBar(){
        switch(self.navigationBarStatus) {
        case .hide:
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        case .opaque:
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.navigationBar.isTranslucent = false
            self.edgesForExtendedLayout = UIRectEdge()
            self.automaticallyAdjustsScrollViewInsets = false
            self.navigationController?.navigationBar.setBackgroundImage(UIImage.image(RGB(248, 208, 15, 1.0), size: CoreGraphics.CGSize(width: MainScreenWidth, height: 128)), for: UIBarMetrics.default)
        case .translucent, .transparent:
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.navigationBar.isTranslucent = true
            self.edgesForExtendedLayout = UIRectEdge.all
            self.automaticallyAdjustsScrollViewInsets = false
            var alpha = CGFloat(0)
            if self.navigationBarStatus == BGNavigationBarStatus.translucent {
                alpha = 0.3
            }
            self.navigationController?.navigationBar.setBackgroundImage(UIImage.image(RGB(0, 0, 0, alpha), size: CoreGraphics.CGSize(width: MainScreenWidth, height: 128)), for: UIBarMetrics.default)
        }
    }
    
    func configureNavigationItem() {
        if self.showLeftBackButton {
            self.navigationItem.leftBarButtonItem = self.letBarButtonItem(UIImage(named:"nav_back.png")!, action: #selector(BGBaseViewController.leftNavigatioItemAction))
        }
        else {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    /** 设置导航栏标题 */
    func setNavTitle(_ title: String) {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: MainScreenWidth, height: 44))
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: MainScreenWidth, height: 44))
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
        titleLabel.textAlignment = NSTextAlignment.center
        
        let width = titleLabel.sizeThatFits(CoreGraphics.CGSize(width: MainScreenWidth, height: 44)).width
        let maxWidth = CGFloat(120)
        if width <= MainScreenWidth-2.0*maxWidth {
            titleLabel.frame = CGRect(x: 0, y: 0, width: MainScreenWidth-maxWidth*2, height: 44);
            titleView.frame = CGRect(x: maxWidth, y: 0, width: MainScreenWidth-maxWidth*2, height: 44);
        }
        else {
            let leftViewbounds = self.navigationItem.leftBarButtonItem?.customView?.bounds
            let rightViewbounds = self.navigationItem.rightBarButtonItem?.customView?.bounds;
            var maxWidth = leftViewbounds!.width > rightViewbounds!.width ? leftViewbounds!.width : rightViewbounds!.width
            maxWidth += 15;
            titleLabel.frame.size.width = MainScreenWidth - maxWidth * 2;
            titleView.frame.size.width = MainScreenWidth - maxWidth * 2;
        }
        //设置标题，添加父视图
        titleLabel.text = title;
        titleView.addSubview(titleLabel)
        self.navigationItem.titleView = titleView;
    }
    
    func letBarButtonItem(_ normalImage: UIImage, action: Selector, selectImage:UIImage? = nil) -> UIBarButtonItem {
        return self.buttonItem("",action: action, titleColor: UIColor.white, normalImage: normalImage, selectImage: nil, isLeftItem: true)
    }
    
    func rightBarButtonItem(_ normalImage: UIImage, action: Selector, selectImage:UIImage? = nil) -> UIBarButtonItem {
        return self.buttonItem("", action: action, titleColor: UIColor.white, normalImage: normalImage, selectImage: nil, isLeftItem: false)
    }
    
    func buttonItem(_ normalImage: UIImage, action: Selector, selectImage:UIImage? = nil, isLeftItem: Bool = true) -> UIBarButtonItem {
        return self.buttonItem("", action: action, titleColor: UIColor.white, normalImage: normalImage, selectImage: nil, isLeftItem: isLeftItem)
    }
    
    fileprivate func buttonItem(_ title: String, action: Selector, titleColor:UIColor = UIColor.white, normalImage: UIImage? = nil, selectImage:UIImage? = nil, isLeftItem: Bool = true) -> UIBarButtonItem {
        let button: UIButton = UIButton(type: UIButton.buttonType.custom)
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(titleColor, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.isExclusiveTouch = true
        button.addTarget(self, action: action, for: UIControl.Event.touchUpInside)
        if let image = normalImage {
            button.setImage(image, for: UIControl.State.normal)
        }
        if let image = selectImage {
            button.setImage(image, for: UIControl.State.highlighted)
        }
        //设置frame
        let buttonSize = button.sizeThatFits(CGSize(width: MainScreenWidth, height: 44.0))
        button.frame = CGRect(x: 0, y: 0, width: buttonSize.width+10, height: 44.0)
        
        //设置偏移量
        if isLeftItem {
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        }
        else {
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        
        //创建barButtonItem
        let buttonItem = UIBarButtonItem(customView: button)
        return buttonItem
    }
    
    func leftNavigatioItemAction (){
        self.navigationController?.popViewController(animated: true)
    }
}
