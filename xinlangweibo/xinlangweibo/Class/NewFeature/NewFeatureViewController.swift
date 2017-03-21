//
//  NewFeatureViewController.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/3/21.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

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
    
}
extension NewFeatureViewController: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
            return 1;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        UICollectionViewCell{ () -> UICollectionViewCell in 
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newFeatureCell", for: indexPath)
        
        
        cell.backgroundColor = UIColor.red;
        return cell
            
//        }
        
        
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
