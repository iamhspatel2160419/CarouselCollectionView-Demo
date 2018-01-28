//
//  ViewController.swift
//  CarouselCollectionView
//
//  Created by hp ios on 1/27/18.
//  Copyright © 2018 andiosdev. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
 @IBOutlet weak var collectionView: UICollectionView!
  private var interests = Interest.createInterests()
    
    let cellScaling:CGFloat = 0.6
    
    
    override func viewDidLoad() {
    
    let screenSize = UIScreen.main.bounds.size
    let cellWidth = floor(screenSize.width*cellScaling)
    let cellHeight = floor(screenSize.height*cellScaling)
    
    let insetX = (view.bounds.width-cellWidth)/2.0
    let insetY = (view.bounds.height-cellHeight)/2.0
   
    let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width:cellWidth,height: cellHeight)
        
    collectionView?.contentInset = UIEdgeInsets(top: insetY,left: insetX,bottom: insetY,right: insetX)
        
        
    collectionView.delegate = self as? UICollectionViewDelegate
    collectionView.dataSource = self
        
    }
    
    private struct Storyboard {
        static let CellIdentifier = "mycell"
    }
    
}
extension ViewController : UICollectionViewDataSource
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return interests.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! InterestCollectionViewCell
        
        cell.interest = self.interests[indexPath.item]
        
        return cell
    }
}
extension ViewController : UIScrollViewDelegate
{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}
