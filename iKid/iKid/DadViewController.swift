//
//  DadViewController.swift
//  iKid
//
//  Created by studentuser on 4/27/16.
//  Copyright © 2016 Vincent Wu. All rights reserved.
//

import UIKit

class DadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstBuilder()
        switchViewController(nil, to: questionController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var questionController : DadQuestionViewController!
    private var answerController : DadAnswerViewController!
    
    
    private func firstBuilder() {
        if questionController == nil {
            questionController = storyboard?.instantiateViewControllerWithIdentifier("DadQuestion") as! DadQuestionViewController
        }
    }
    
    private func secondBuilder() {
        if answerController == nil {
            answerController = storyboard?.instantiateViewControllerWithIdentifier("DadAnswer") as! DadAnswerViewController
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
