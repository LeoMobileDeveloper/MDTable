//
//  Banner.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/4.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

import Foundation
import UIKit

public enum ParallexBannerTransition{
    case Normal
    case Parallex
    //Maybe I will add some transition in the future
}
public protocol ParallexBannerDelegate: class{
    func banner(banner:ParallexBanner,didClickAtIndex index:NSInteger)
    func banner(banner:ParallexBanner,didScrollToIndex index:NSInteger)
}

public protocol ParallexBannerDataSource: class{
    func numberOfBannersIn(bannner:ParallexBanner)->NSInteger
    func banner(banner:ParallexBanner, imageAt index:NSInteger)->BannerItem

}

public class ParallexBanner: UIView {
    // MARK: - Propertys -
    public  weak var dataSource:ParallexBannerDataSource?
    public  weak var delegate:ParallexBannerDelegate?
    /// The transitionMode when scroll,default is .Parallex
    public  var transitionMode:ParallexBannerTransition = ParallexBannerTransition.Parallex
    /// Weather to enable timer based scroll
    public  var autoScroll:Bool = true {
        didSet{
            if autoScroll{
                restartTimerIfNeeded()
            }else{
                stopTimerIfNecessory()
            }
        }
    }
    /// Weather to enable scroll if there is only one page
    public  var enableScrollForSinglePage = false
    /// The speed of parallex scroll,it should between 0.1 to 0.8
    public  var parllexSpeed:CGFloat = 0.4
    /// The duration between an auto scroll fire
    public  var autoScrollTimeInterval:TimeInterval = 3.0 {
        didSet{
            stopTimerIfNecessory()
            restartTimerIfNeeded()
        }
    }
    /// The page Control
    public  let pageControl:UIPageControl = UIPageControl()
    /// The current index of page
    public  var currentIndex:Int{
        get{
            if _currentIndex == 0 {
                return self.dataSource!.numberOfBannersIn(bannner: self) + 2 - 3
            }else if(_currentIndex == self.dataSource!.numberOfBannersIn(bannner: self) + 2 - 1){
                return  0;
            }else{
                return _currentIndex - 1
            }
        }
    };
    
    var _currentIndex = 1
    var collectionView:UICollectionView!
    var timer:Timer?
    var flowLayout:UICollectionViewFlowLayout!
    
    // MARK: - Init -
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit(){
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0.0
        collectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
        pageControl.pageIndicatorTintColor = UIColor.init(white: 1.0, alpha: 0.65)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 210.0 / 255.0, green: 61.0 / 255.0, blue: 57.0 / 255.0, alpha: 0.65)
        pageControl.hidesForSinglePage = true
        pageControl.isUserInteractionEnabled = false
        addSubview(collectionView)
        addSubview(pageControl)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "cell")
    }
    // MARK: - Layout -
    public override func layoutSubviews() {
        super.layoutSubviews()
        flowLayout.itemSize = self.frame.size
        if let ds = self.dataSource{
            pageControl.numberOfPages = ds.numberOfBannersIn(bannner: self)
        }else{
            pageControl.numberOfPages = 0
        }
        pageControl.sizeToFit()
        collectionView.frame = self.bounds
        pageControl.center = CGPoint(x: self.bounds.width/2, y: self.bounds.size.height - pageControl.bounds.height / 2 + 8.0)
        let originIndexPath = NSIndexPath(item: _currentIndex, section: 0)
        if let ds = dataSource{
            let targetCount = ds.numberOfBannersIn(bannner: self);
            let needAdjust = targetCount > 1 || (targetCount == 1 && enableScrollForSinglePage)
            if needAdjust{
                collectionView.scrollToItem(at: originIndexPath as IndexPath, at: .right, animated: false)
            }
        }
    }
    // MARK: - API -
    public func reloadData(){
        _currentIndex = 1;
        collectionView.reloadData()
        stopTimerIfNecessory()
        if let ds = self.dataSource{
            let targetCount = ds.numberOfBannersIn(bannner: self);
            pageControl.numberOfPages = targetCount
            pageControl.currentPage = 0
            restartTimerIfNeeded()
        }else{
            pageControl.numberOfPages = 0
        }
        setNeedsLayout()
    }
    // MARK: - Life Circle -
    public override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil{
            stopTimerIfNecessory()
        }
        super.willMove(toSuperview: newSuperview)
    }
    deinit{
        stopTimerIfNecessory()
    }
    // MARK: - Private -
    func restartTimerIfNeeded(){
        stopTimerIfNecessory()
        if  autoScroll == false {
            return
        }
        let count = self.dataSource!.numberOfBannersIn(bannner: self)
        guard count != 0 else{
            return
        }
        if count == 1 && enableScrollForSinglePage == false{
            return
        }
        self.timer = Timer(timeInterval: self.autoScrollTimeInterval, target: self, selector: #selector(ParallexBanner.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer!, forMode: .commonModes)
    }
    func stopTimerIfNecessory(){
        if self.timer != nil{
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    @objc private func scrollToNext(){
        _currentIndex = (_currentIndex + 1) % (self.dataSource!.numberOfBannersIn(bannner: self) + 2);
        let nextIndx = IndexPath(item: _currentIndex, section: 0)
        collectionView.scrollToItem(at: nextIndx, at: .right, animated: true)
    }
}

//Handle dataSource/Delegate and scrollViewScroll
extension ParallexBanner:UICollectionViewDataSource,UICollectionViewDelegate{
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.dataSource != nil else{
            return 0
        }
        let count = self.dataSource!.numberOfBannersIn(bannner: self);
        guard count != 0 else{
            return 0
        }
        if count == 1 && enableScrollForSinglePage == false{
            return count;
        }
        return count + 2;
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        assert(dataSource != nil)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BannerCell
        let index = indexPath.item;
        var adjustIndex = index
        if index == 0{
            adjustIndex = self.dataSource!.numberOfBannersIn(bannner: self) + 2 - 3
        }else if index == self.dataSource!.numberOfBannersIn(bannner: self) + 2 - 1 {
            adjustIndex = 0;
        }else{
            adjustIndex = index - 1
        }
        let item = self.dataSource?.banner(banner: self, imageAt: adjustIndex)
        cell.config(item: item!)
        handleEffect(cell: cell)
        return cell

    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.delegate?.banner(banner: self, didClickAtIndex: currentIndex)
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard autoScroll else{
            return;
        }
        stopTimerIfNecessory()
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard autoScroll else{
            return;
        }
        restartTimerIfNeeded()
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offSetX = scrollView.contentOffset.x
        let width = scrollView.bounds.width
        guard width != 0 else{
            return
        }
        if offSetX >= width * CGFloat(self.dataSource!.numberOfBannersIn(bannner: self) + 2 - 1){
            offSetX = width;
            scrollView.contentOffset = CGPoint(x: offSetX, y: 0)
        }else if(offSetX < 0 ){
            offSetX = width * CGFloat(self.dataSource!.numberOfBannersIn(bannner: self) + 2 - 2);
            scrollView.contentOffset = CGPoint(x: offSetX, y: 0)
        }
        _currentIndex = Int((offSetX + width / 2.0) / width);
        if pageControl.currentPage != currentIndex{
            pageControl.currentPage = currentIndex
            self.delegate?.banner(banner: self, didScrollToIndex: currentIndex)
            
        }
        //Calculate offset for visiable cell
        collectionView.visibleCells.forEach { (cell) in
            if let bannerCell = cell as? BannerCell{
                handleEffect(cell: bannerCell)
            }
        }

    }
    private func handleEffect(cell:BannerCell){
        switch transitionMode {
        case .Parallex:
            let minusX = self.collectionView.contentOffset.x - cell.frame.origin.x
            let imageOffsetX = -minusX * parllexSpeed;
            cell.scrollView.contentOffset = CGPoint(x: imageOffsetX, y: 0)
        default:
            break
        }
    }
}

public class BannerCell:UICollectionViewCell{
    let imageView = UIImageView()
    let textLabel = LeftRoundLabel(frame: CGRect.zero)
    let scrollView = UIScrollView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    private func commonInit(){
        contentView.addSubview(scrollView)
        scrollView.isScrollEnabled = false
        scrollView.isUserInteractionEnabled = false
        
        scrollView.addSubview(imageView)
        imageView.contentMode = UIViewContentMode.scaleAspectFill;
        imageView.addSubview(textLabel)
        textLabel.font = UIFont.systemFont(ofSize: 10)
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .center
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentSize = self.bounds.size;
        scrollView.frame = self.bounds
        imageView.frame = scrollView.bounds
        textLabel.frame = CGRect(x: imageView.frame.width - textLabel.frame.width,
                                 y: imageView.frame.height - 4.0 - textLabel.frame.height,
                                 width: textLabel.frame.width,
                                 height: textLabel.frame.height)
        textLabel.roundCorners([.bottomLeft,.topLeft], radius: 10)
    }
    public func config(item:BannerItem){
        imageView.image = item.image
        textLabel.text = item.type
        textLabel.backgroundColor = item.color
        textLabel.sizeToFit()
        setNeedsLayout()
    }
}

public class LeftRoundLabel: UILabel{
    private let maskLayer = CAShapeLayer()
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func sizeToFit() {
        super.sizeToFit()
        var size = self.frame.size
        size.width = size.width + size.height
        size.height = size.height + 6.0
        self.frame.size = size
    }
}

public class BannerItem{
    var image:UIImage?
    var type:String
    var color:UIColor
    init(image:UIImage?, type:String, color:UIColor) {
        self.image = image
        self.type = type
        self.color = color
    }
}
