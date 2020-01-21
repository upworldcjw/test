//
//  BGSelectImageLayout.swift
//  BGSimpleImageSelectCollectionView
//
//  Created by user on 15/10/27.
//  Copyright © 2015年 BG. All rights reserved.
//

import UIKit

protocol BGSelectImageLayoutDelegate: NSObjectProtocol {
    /**
     选择了某个索引
     
     - parameter layout:          layout
     - parameter selectIndexPath: 选择的索引
     */
    func selectImageLayout(_ layout: BGSelectImageLayout, selectIndexPath: IndexPath)
}

/// 此布局，只有一组，没有多组
class BGSelectImageLayout: UICollectionViewLayout {
    // MARK: - properties
    /// 内容区域
    var contentInset: UIEdgeInsets = UIEdgeInsets.zero
    /// 每个cell的间距
    var interitemSpacing: CGFloat = 10
    /// 每个cell大小
    var itemSize: CGSize = CoreGraphics.CGSize(width: 45, height: 45);
    /// 代理
    weak var delegate: BGSelectImageLayoutDelegate? = nil
    
    /// cell布局信息
    fileprivate var layoutInfoDic = [IndexPath:UICollectionViewLayoutAttributes]()
    
    /// 需要刷新的时候indexPath
    fileprivate var reloadIndexPathArr = [IndexPath]()
    /// 删除的indexPath集合
    fileprivate var deleteIndexPathArr = [IndexPath]()
    /// 插入的indexPath集合
    fileprivate var insertIndexPathArr = [IndexPath]()
    /// 移动前的indexPath
    fileprivate var beforeMoveIndexPath = IndexPath(row: 0, section: 0)
    /// 移动后的indexPath
    fileprivate var afterMoveIndexPath = IndexPath(row: 0, section: 0)
    
    /// 更新动画类型
    fileprivate var animationType:UICollectionViewUpdateItem.Action = .none
    
    /// 上一次选中的indexPath
    fileprivate var lastSelectIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    /// 当前选中的indexPath
    fileprivate var currentSelectIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    /// 选中的indexPath
    var selectIndexPath: IndexPath {
        get {
            return self.currentSelectIndexPath
        }
        set (indexPath) {
            if indexPath != self.currentSelectIndexPath {
                self.lastSelectIndexPath = self.currentSelectIndexPath
                self.currentSelectIndexPath = indexPath
                self.collectionView?.reloadSections(IndexSet(index: 0) as IndexSet)
                //调用代理方法
                self.delegate?.selectImageLayout(self, selectIndexPath: indexPath)
            }
            else{
                self.collectionView?.scrollToItem(at: self.currentSelectIndexPath as IndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            }
        }
    }
    
    // MARK: - must override methods
    override func prepare() {
        super.prepare()
        
        //重置数组
        self.layoutInfoDic = [IndexPath:UICollectionViewLayoutAttributes]()
        
        //布局只取第0组的信息
        if let numOfItems = self.collectionView?.numberOfItems(inSection: 0) {
            for i in 0 ..< numOfItems {
                let indexPath = NSIndexPath(item: i, section: 0)
                if let attributes = self.layoutAttributesForItem(at: indexPath as IndexPath) {
                    self.layoutInfoDic[indexPath as IndexPath] = attributes
                }
            }
        }
        
    }
    
    var collectionViewContentSize : CGSize {
        if let numOfItems = self.collectionView?.numberOfItems(inSection: 0) {
            return CoreGraphics.CGSize(width: (self.itemSize.width+self.interitemSpacing)*CGFloat(numOfItems+1)+self.interitemSpacing+self.contentInset.left+self.contentInset.right, height: self.itemSize.height+self.contentInset.top+self.contentInset.bottom)
        }
        else {
            return self.collectionView!.frame.size
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArr = [UICollectionViewLayoutAttributes]()
        //遍历布局信息
        for arttibutes in self.layoutInfoDic.values {
            //判断arttibutes当中的区域与rect是否存在交集
            if arttibutes.frame.intersects(rect) {
                attributesArr.append(arttibutes)
            }
        }
        return attributesArr
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
        attributes.frame = self.currentSelectIndexPath(indexPath)
        return attributes
    }
    
    // MARK: - option override method
//    //此方法刷新动画的时候会调用
//    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
//        let frame = self.currentFrameWithIndexPath(self.currentSelectIndexPath)
//        return CGPointMake(frame.centerX-self.collectionView!.width/2.0, 0)
//    }
    
    // MARK: animation method
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        //数组重置
        self.reloadIndexPathArr = [IndexPath]()
        self.deleteIndexPathArr = [IndexPath]()
        self.insertIndexPathArr = [IndexPath]()
        
        //保存更新的indexPath
        for item in updateItems {
            switch item.updateAction {
            case .insert:
                    let indexPath = item.indexPathAfterUpdate
                    self.insertIndexPathArr.append(indexPath as! IndexPath)
                    self.animationType = .insert
            case .delete:
                    let indexPath = item.indexPathBeforeUpdate
                    self.deleteIndexPathArr.append(indexPath as! IndexPath)
                    self.animationType = .delete
            case .reload:
                    let indexPath = item.indexPathBeforeUpdate
                    self.reloadIndexPathArr.append(indexPath as! IndexPath)
                    self.animationType = .reload
            case .move:
                self.beforeMoveIndexPath = item.indexPathBeforeUpdate as! IndexPath
                self.afterMoveIndexPath = item.indexPathAfterUpdate as! IndexPath
                self.animationType = .move
            case .none:
                self.animationType = .none
                    break
//            case .insert:
//                <#code#>
//            case .delete:
//                <#code#>
//            case .reload:
//                <#code#>
//            case .move:
//                <#code#>
//            case .none:
//                <#code#>
//            }
        }
    }
    
    func finalizeCollectionViewUpdates() {
        
    }
    
  
    
    
        func initialLayoutAttributesForAppearingItemAtIndexPath(_ itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //此处需要用到copy，否则属性变量一次变化之后，会被保存，然后会出现移动那个动画
            let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath as IndexPath)?.copy() as? UICollectionViewLayoutAttributes
        switch self.animationType {
        case .insert:
            if self.insertIndexPathArr.contains(itemIndexPath) {
                attributes?.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                attributes?.alpha = 0
            }
            else {
                //设置为前一个item的frame
                
                attributes?.frame = self.currentSelectIndexPath(IndexPath(row: itemIndexPath.row-1, section: itemIndexPath.section))
            }
        case .delete:
            attributes?.frame = self.currentSelectIndexPath(IndexPath(row: itemIndexPath.row+1, section: itemIndexPath.section))
        case .move:
            if itemIndexPath == self.afterMoveIndexPath {
                //afterMoveIndexPath的消失动画和beforeMoveIndexPath的出现动画重合
                //init是设置起点，而final设置终点，理论是不重合的
//                attributes?.transform3D = CATransform3DMakeRotation(3.0/2.0*CGFloat(M_PI), 0, 0, 1)
            }
        case .reload:
            attributes?.frame = self.lastSelectIndexPath(itemIndexPath)
            
        default:
            break
        }
        print("init:")
        print(attributes)
        return attributes
    }
    
     func finalLayoutAttributesForDisappearingItemAtIndexPath(_ itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath as IndexPath)?.copy() as? UICollectionViewLayoutAttributes
        switch self.animationType {
        case .insert:
            attributes?.frame = self.currentSelectIndexPath(IndexPath(forRow: itemIndexPath.row+1, inSection: itemIndexPath.section))
        case .delete:
            if self.deleteIndexPathArr.contains(itemIndexPath) {
                //这里写成缩放成(0，0)直接就不见了
                attributes?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                attributes?.alpha = 0.0
            }
            else {
                attributes?.frame = self.currentSelectIndexPath(IndexPath(forRow: itemIndexPath.row-1, inSection: itemIndexPath.section))
            }
        case .move:
            if self.beforeMoveIndexPath == itemIndexPath {
                //afterMoveIndexPath的消失动画和beforeMoveIndexPath的出现动画重合，设置他们旋转的角度一样，方向相反
//                attributes?.transform3D = CATransform3DMakeRotation(1.0/2.0*CGFloat(M_PI), 0, 0, 1)
            }
        case .reload:
            attributes?.alpha = 1.0
            attributes?.frame = self.currentSelectIndexPath(itemIndexPath)
        default:
            break
        }
        print("fina:")
        print(attributes)
        return attributes
    }
    
    // MARK: - private method
    func currentFrameWithIndexPath(_ indexPath: IndexPath) -> CGRect {
        return self.frameWithIndexPath(indexPath, selectIndexPath: self.currentSelectIndexPath)
    }
    func lastFrameWithIndexPath(_ indexPath: IndexPath) -> CGRect {
        return self.frameWithIndexPath(indexPath:indexPath, selectIndexPath: self.lastSelectIndexPath)
    }
    func frameWithIndexPath(_ indexPath: IndexPath, selectIndexPath: IndexPath) -> CGRect {
        var left: CGFloat
        var width: CGFloat
        if indexPath.row < selectIndexPath.row {
            left = CGFloat(indexPath.row)*(self.itemSize.width+self.interitemSpacing)
            width = self.itemSize.width
        }
        else if indexPath.row == selectIndexPath.row {
            left = CGFloat(indexPath.row)*(self.itemSize.width+self.interitemSpacing)+self.interitemSpacing
            width = self.itemSize.width*2
        }
        else {
            left = CGFloat(indexPath.row+1)*(self.itemSize.width+self.interitemSpacing)+self.interitemSpacing
            width = self.itemSize.width
        }
        let frame = CGRect(x: left+self.contentInset.left, y: CGFloat(indexPath.section)*self.itemSize.height+self.contentInset.top, width: width, height: self.itemSize.height)
        return frame
    }
    
    func printAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        print("attributes:")
        print("frame:\(attributes.frame)")
        print("indexPath:\(attributes.indexPath)")
        print("transform:\(attributes.transform)")
        print("alpha:\(attributes.alpha)")
    }
}
