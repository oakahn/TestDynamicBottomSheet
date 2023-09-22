//
//  ViewController.swift
//  Scrollbar
//
//  Created by Chayawat Suntornrak on 11/8/2566 BE.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollVIew: UIScrollView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var topScrollView: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    
    private var top: CGFloat = 0
    private var heightBottomSheet: CGFloat = 0
    
    private let minHeight: CGFloat = 380
    private var heightScreen: CGFloat = 0
    private let maxHeight: CGFloat = 550
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightScreen = UIScreen.main.bounds.height - heightSafeArea - bottomHeightSafeArea
        
        scrollVIew.layer.cornerRadius = 16
        contentView.layer.cornerRadius = 16
        
        
        scrollVIew.delegate = self
        textLabel.font = UIFont(name: "Impact", size: 48)
        let longText = "label \n label \n label \n label \n label \n label \n label \n label \n label \n label \n"
        let middleText = "label \n label \n label \n label \n label \n label \n label"
        let shortText = "label \n label \n label"
        
        let string = middleText
        
        let width = UIScreen.main.bounds.width - 16 - 16
        let heightImage: CGFloat = 84 + 16 + 16
        let heightLabel = string.height(withConstrainedWidth: width, font: UIFont(name: "Impact", size: 48)!) + 16
        
        
        let heightBottomSheet = heightImage + heightLabel
        self.heightBottomSheet = heightBottomSheet
        
        
//        print("heightBottomSheet", heightBottomSheet)
//        print("aa", UIScreen.main.bounds.height - heightBottomSheet)
//        top = UIScreen.main.bounds.height - heightBottomSheet
//        topScrollView.constant = UIScreen.main.bounds.height - heightBottomSheet
        
        
        textLabel.text = string
        
        /**
         if height bottom sheet more than 500 give bottom sheet height is 500
         
         */
        print("heightBottomSheet", heightBottomSheet)
//        topScrollView.constant = heightBottomSheet > minHeight ? heightScreen - heightBottomSheet : heightScreen - minHeight
        topScrollView.constant = heightScreen - minHeight
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("~~> scrollView", scrollView.contentOffset)
        
        if scrollView.contentOffset.y > 300/2 {
            topScrollView.constant = heightBottomSheet > maxHeight ? heightScreen - maxHeight : heightScreen - heightBottomSheet
            UIView.animate(withDuration: 0.2) {
                self.scrollVIew.layoutIfNeeded()
            }
            return
        }
            
            
//
        if scrollView.contentOffset.y <= -50 {
            topScrollView.constant = heightScreen - minHeight
            UIView.animate(withDuration: 0.2) {
                self.scrollVIew.layoutIfNeeded()
            }
            return
        }
//
//        if scrollView.contentOffset.y > 128 {
//            topScrollView.constant = top
//            UIView.animate(withDuration: 0.1) {
//                self.scrollVIew.layoutIfNeeded()
//            }
    }
}


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        
        return ceil(boundingBox.height)
    }
}

extension UIViewController {
    var heightSafeArea: CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.top ?? 0
    }
    var bottomHeightSafeArea: CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.bottom ?? 0
    }
}
