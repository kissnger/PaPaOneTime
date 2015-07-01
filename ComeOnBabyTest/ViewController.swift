//
//  ViewController.swift
//  ComeOnBabyTest
//
//  Created by Massimo on 15/6/29.
//  Copyright (c) 2015年 Massimo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
  let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
  var cuteView : KYCuteView!
  var inputPenView : CKPenInputView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    createBubbleView()

  }
  func createBubbleView(){

    inputPenView = NSBundle.mainBundle().loadNibNamed("CKPenInputView", owner: self, options: nil)[0] as! CKPenInputView
    inputPenView.frame = self.view.bounds
    self.view.addSubview(inputPenView)
    inputPenView.hidden = true
    cuteView = KYCuteView(point: CGPointMake(25, SCREEN_HEIGHT * 0.75), superView: self.view)
    cuteView.viscosity = 30
    cuteView.bubbleWidth = 35
    cuteView.bubbleColor = UIColor.blueColor()
    cuteView.setUp()
    cuteView.addGesture()
    cuteView.bubbleLabel.text = "喷"
    cuteView.frontView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapBubble:"))
  }
  func tapBubble(tap:UITapGestureRecognizer){
    inputPenView.hidden = false
    inputPenView.textV.becomeFirstResponder()
    self.view.bringSubviewToFront(inputPenView)
  }
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "configKeyboardHeight:", name: UIKeyboardDidShowNotification, object: nil)
  }
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self, forKeyPath: UIKeyboardDidShowNotification)
  }

  func configKeyboardHeight(noti:NSNotification){

//    let height = noti.userInfo

  }



  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

