//
//  BowView.swift
//  StudySketch&PaintCode
//
//  Created by Mr.Zhu on 2017/11/4.
//  Copyright © 2017年 Zx. All rights reserved.
//

import UIKit

@IBDesignable
class BowView: UIView {

    @IBInspectable var BackColor: UIColor = UIColor.red
    @IBInspectable var CountColor: UIColor = UIColor.blue

    private struct Constants {
        static let numberOfGlasses = 8
        static let lineWidth: CGFloat = 5.0
        static let arcWidth: CGFloat = 76
        
        static var halfOfLineWidth: CGFloat {
            return lineWidth / 2
        }
    }
    
    @IBInspectable var GlassesCount: Int = 0{
        
        didSet{
            if GlassesCount <= Constants.numberOfGlasses && GlassesCount >= 0{
                self.setNeedsDisplay()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        bbbb(rect)
    }
    func bbbb(_ rect: CGRect){
        let path = UIBezierPath()
        
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius = min(bounds.width, bounds.height)/2 - Constants.arcWidth/2
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = Constants.arcWidth
        BackColor.setStroke()
        path.stroke()
        
        //算出每个杯子的弧度
        let GlassLenth: CGFloat = (2 * .pi - startAngle + endAngle)/CGFloat(Constants.numberOfGlasses)
        //算出当前杯子路径的结束弧度
        let outlineEndAngle = CGFloat(GlassesCount) * GlassLenth + startAngle
        //添加路径
        let outlinePath = UIBezierPath(arcCenter: center, radius: bounds.width/2 - Constants.halfOfLineWidth, startAngle: startAngle, endAngle: outlineEndAngle, clockwise: true)
        
        outlinePath.addArc(withCenter: center, radius: bounds.width/2 - Constants.arcWidth+Constants.halfOfLineWidth, startAngle:outlineEndAngle , endAngle: startAngle, clockwise: false)
        
        outlinePath.lineWidth = Constants.halfOfLineWidth*2
         outlinePath.close()
         CountColor.setStroke()
        outlinePath.stroke()
        //Bow View markers
        let context = UIGraphicsGetCurrentContext()!
        
        //1 - save original state
        context.saveGState()
        CountColor.setFill()
        
        let markerWidth: CGFloat = 5.0
        let markerSize: CGFloat = 10.0
        
        //2 - the marker rectangle positioned at the top left
        let markerPath = UIBezierPath(rect: CGRect(x: -markerWidth / 2, y: 0, width: markerWidth, height: markerSize))
        
        //3 - move top left of context to the previous center position
        context.translateBy(x: rect.width / 2, y: rect.height / 2)
        
        for i in 1...Constants.numberOfGlasses {
            //4 - save the centred context
            context.saveGState()
            //5 - calculate the rotation angle
            let angle = GlassLenth * CGFloat(i) + startAngle - .pi / 2
            //rotate and translate
            context.rotate(by: angle)
            context.translateBy(x: 0, y: rect.height / 2 - markerSize)
            
            //6 - fill the marker rectangle
            markerPath.fill()
            //7 - restore the centred context for the next rotate
            context.restoreGState()
        }
        
        //8 - restore the original state in case of more painting
        context.restoreGState()
        
    }
    
}
