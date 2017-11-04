//
//  ViewController.swift
//  StudySketch&PaintCode
//
//  Created by Mr.Zhu on 2017/11/3.
//  Copyright © 2017年 Zx. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CAAnimationDelegate {

    
    var isGraphViewShow: Bool = false
    
    var mySlider:UISlider?
    
    @IBOutlet weak var GraphView: GraphView!
    @IBOutlet weak var bowView: BowView!
    @IBOutlet weak var countLabel: UILabel!
    
    //Label outlets
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBAction func pushBtnOnClick(_ sender: addAndminus_Button) {
        if sender.isAddButton{
            bowView.GlassesCount += 1
        }else{
            bowView.GlassesCount -= 1
        }
        print("bowView.GlassesCount:\(bowView.GlassesCount)")
        countLabel.text = String(bowView.GlassesCount)
        if isGraphViewShow{
            BowViewTap(nil)
        }
    }
  
    @IBAction func BowViewTap(_ sender: UITapGestureRecognizer?) {
        if isGraphViewShow{
            UIView.transition(from: GraphView, to: bowView, duration: 1.0, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
        }else{
            UIView.transition(from: bowView, to: GraphView, duration: 1.0, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
            setupGraphDisplay()
        }
        isGraphViewShow = !isGraphViewShow
    }
    
    func setupGraphDisplay() {
        
        let maxDayIndex = stackView.arrangedSubviews.count - 1
        
        //  1 - replace last day with today's actual data
        GraphView.graphPoints[GraphView.graphPoints.count - 1] = bowView.GlassesCount
        //2 - indicate that the graph needs to be redrawn
        GraphView.setNeedsDisplay()
        maxLabel.text = "\((GraphView.graphPoints.max())!)"
        
        //  3 - calculate average from graphPoints
        let average = GraphView.graphPoints.reduce(0, +) / GraphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        
        // 4 - setup date formatter and calendar
        let today = Date()
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEEE")
        
        // 5 - set up the day name labels with correct days
        for i in 0...maxDayIndex {
            if let date = calendar.date(byAdding: .day, value: -i, to: today),
                let label = stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = formatter.string(from: date)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = String(bowView.GlassesCount)
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

