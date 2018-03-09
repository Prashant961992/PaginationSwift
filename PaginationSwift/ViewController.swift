//
//  ViewController.swift
//  PaginationSwift
//
//  Created by Prashant Prajapati on 09/03/18.
//  Copyright © 2018 Prashant Prajapati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var arrnames = ["1","2","3","4","5","6","7"]
    var timerTest : Timer?
    
    @IBOutlet weak var pageController: UIPageControl! {
        didSet {
            pageController?.addTarget(self, action: #selector(ViewController.pageChange(_:)), for: .valueChanged)
        }
    }
    
    @IBOutlet weak var CollectionViewSlider: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionViewSlider.dataSource = self
        CollectionViewSlider.delegate = self
        
        pageController.numberOfPages = arrnames.count
        //        cell.pageCount.currentPage = indexPath.row
        pageController.tintColor = .red
        pageController.pageIndicatorTintColor = .black
        pageController.currentPageIndicatorTintColor = .blue
        
        startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func scrollAutomatically(_ timer1: Timer) {
        if let coll  = CollectionViewSlider {
            for cell in CollectionViewSlider.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)!  < arrnames.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)

//                    let cell = coll.dequeueReusableCell(withReuseIdentifier: "PaginationcCollectionCell", for: indexPath1!) as! PaginationcCollectionCell
////                    let cell = coll.cellForItem(at: indexPath1!) as! PaginationcCollectionCell
                    pageController.currentPage = (indexPath1?.row)!
                    
                    UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
                        self.CollectionViewSlider.scrollToItem(at: indexPath1!, at: .right, animated: true)
                    }, completion: nil)
                }
                else{
                    
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: false)
                    
//                    let cell = coll.dequeueReusableCell(withReuseIdentifier: "PaginationcCollectionCell", for: indexPath1!) as! PaginationcCollectionCell
                    pageController.currentPage = (indexPath1?.row)!
                }
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        for cell: UICollectionViewCell in CollectionViewSlider.visibleCells {
            let indexPath: IndexPath? = CollectionViewSlider.indexPath(for: cell)
            print(indexPath as Any)
            pageController.currentPage = (indexPath?.row)!
        }
        //startTimer()
    }
    
    func startTimer(){
      timerTest = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
//    func stopTimer() {
//        if timerTest != nil {
//            timerTest?.invalidate()
//            timerTest = nil
//        }
//    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//       // stopTimer()
//    }

    @IBAction func pageChange(_ sender: Any) {
        print((sender as AnyObject).currentPage)
    }
}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrnames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaginationcCollectionCell", for: indexPath) as! PaginationcCollectionCell
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = .green
        }else{
            cell.backgroundColor = .red
        }
      
        
        cell.labelTitalCount.text = arrnames[indexPath.row]
        
//        if ((indexPath.row)  < arrnames.count - 1){
//            cell.pageCount.currentPage = indexPath.row
//        }
//        else{
//            cell.pageCount.currentPage = 0
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: CollectionViewSlider.frame.size.width, height: CollectionViewSlider.frame.size.height)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0.0
    }
}
