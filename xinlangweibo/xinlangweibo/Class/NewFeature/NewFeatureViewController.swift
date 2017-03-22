//
//  NewFeatureViewController.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/3/21.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit
import SnapKit
let MaxCount = 4

class NewFeatureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
extension NewFeatureViewController:UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let index = collectionView.indexPathsForVisibleItems.last!
        
        let currentCell = collectionView.cellForItem(at: index) as! newFeatureCollectionCell
        
        if index.item ==  MaxCount - 1{
            
            currentCell.startAnimate();
            
        }
        
    }
}
extension NewFeatureViewController: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
            return 1;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MaxCount;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newFeatureCell", for: indexPath) as! newFeatureCollectionCell
        
        
        cell.index = indexPath.row + 1;
        return cell
  
    }
    
}


///自定义cell
class newFeatureCollectionCell:UICollectionViewCell
{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setupUI();
    }
    
    func startAnimate(){
        
        startBtn.isHidden = false;
        //做动画
        
        // 动画时长
        //动画延迟
        //振幅 0.0-1.0 值越大震动越厉害
        //加速度 ，值越大震动越厉害
        //动画附加属性
        //执行动画的block
        //执行完毕后的回调
        startBtn.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
        startBtn.isUserInteractionEnabled = false;
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.startBtn.transform = CGAffineTransform.identity;
        }, completion: { (bool) in
            self.startBtn.isUserInteractionEnabled = true;
        })

    }
    
    private func setupUI()
    {
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(startBtn)
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.edges.equalTo(0);
        }
        startBtn.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(contentView);
            make.bottom.equalTo(contentView).offset(-130);
            
        }
    }
    
    var index:Int = 1
        {
        didSet{
            
            let name = "new_feature_\(index)"
            
            iconImageView.image = UIImage(named: name);
            


        }
    }
    
    
    ///布局子控件
    
    
    private lazy var iconImageView = UIImageView()
    private lazy var startBtn:UIButton = {
        
        let btn = UIButton(image: "", backgroundImage: "new_feature_button");
        btn.addTarget(self, action:#selector(newFeatureCollectionCell.startBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    @objc private func startBtnClicked(){
        
    }
}

// MARK: - 自定义布局
class NewFeatureLyout:UICollectionViewFlowLayout
{
    // 准备布局
    override func prepare() {
        //设置cell尺寸
        itemSize = UIScreen.main.bounds.size;
        minimumLineSpacing = 0;
        minimumInteritemSpacing = 0;
        scrollDirection = UICollectionViewScrollDirection.horizontal
        
        collectionView?.isPagingEnabled = true;
        //禁止回弹
        collectionView?.bounces = false;
    }
}
