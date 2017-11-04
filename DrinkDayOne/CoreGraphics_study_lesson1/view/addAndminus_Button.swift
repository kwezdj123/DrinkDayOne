//
//  add&minus_Button.swift
//  StudySketch&PaintCode
//
//  Created by Mr.Zhu on 2017/11/4.
//  Copyright © 2017年 Zx. All rights reserved.
//

import UIKit

@IBDesignable
class addAndminus_Button: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.purple
    @IBInspectable var isAddButton: Bool = true
    private struct Constants {
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width/2
    }
    private var halfHeight: CGFloat {
        return bounds.height/2
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        aaa(rect)
        
        
    }
    
    func aaa(_ rect: CGRect){
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        let plusWidth:  CGFloat = min(bounds.width, bounds.height)*Constants.plusButtonScale
        let halfplusWidth = plusWidth/2
        
        let plusPath = UIBezierPath()
        plusPath.lineWidth = Constants.plusLineWidth
        
        plusPath.move(to: CGPoint(x: halfWidth-halfplusWidth, y: halfWidth))
        plusPath.addLine(to: CGPoint(x: halfWidth+halfplusWidth, y: halfWidth))
        if isAddButton{
            plusPath.move(to: CGPoint(x: halfWidth, y: halfWidth-halfplusWidth))
            plusPath.addLine(to: CGPoint(x: halfWidth, y: halfWidth+halfplusWidth))
        }
        UIColor.white.set()
        plusPath.stroke()
        
    }

}





