//
//  PunViewController.swift
//  iKid
//
//  Created by studentuser on 4/27/16.
//  Copyright © 2016 Vincent Wu. All rights reserved.
//

import UIKit

class PunViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        firstBuilder()
        switchViewController(nil, to: questionController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var questionController : PunQuestionViewController!
    private var answerController : PunAnswerViewController!
    
    
    private func firstBuilder() {
        if questionController == nil {
            questionController = storyboard?.instantiateViewControllerWithIdentifier("PunQuestion") as! PunQuestionViewController
        }
    }
    
    private func secondBuilder() {
        if answerController == nil {
            answerController = storyboard?.instantiateViewControllerWithIdentifier("PunAnswer") as! PunAnswerViewController
        }
    }
    
    @IBAction func showAnswer(sender: UIButton) {
        secondBuilder()
        firstBuilder()
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.EaseInOut)
        
        if questionController != nil && questionController?.view.superview != nil {
            UIView.setAnimationTransition(.FlipFromRight, forView: view, cache: true)
            answerController.view.frame = view.frame
            switchViewController(questionController, to: answerController)
        } else {
            UIView.setAnimationTransition(.FlipFromLeft, forView: view, cache: true)
            questionController.view.frame = view.frame
            switchViewController(answerController, to: questionController)
        }
        UIView.commitAnimations()
    }
    
    private func switchViewController(from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMoveToParentViewController(nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, atIndex: 0)
            to!.didMoveToParentViewController(self)
        }
    }
    


}

