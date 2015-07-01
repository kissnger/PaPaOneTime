//
//  CKPenInputView.swift
//  ComeOnBabyTest
//
//  Created by Massimo on 15/6/29.
//  Copyright (c) 2015年 Massimo. All rights reserved.
//

import UIKit
import AVFoundation
class CKPenInputView: UIView {
//  let itemHeight = CGFloat(60)
  let spaceX = CGFloat(7.5)
  @IBOutlet weak var emjoView: UIView!

  @IBOutlet weak var textV: UITextField!

  @IBOutlet weak var emjoBtn: UIButton!
  let arr = ["乌","来一发","喷","火箭","臭虫","发疯","啪啪"]

  var player : AVAudioPlayer!
  @IBOutlet weak var inputViewLayoutHeight: NSLayoutConstraint!


  var inputViewHeight = CGFloat(308){
      didSet{
        inputViewLayoutHeight.constant = inputViewHeight + 50
      }
  }


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

  override func awakeFromNib() {

    createSound()
  }
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    createViews()
    createItems()
  }

  func createSound(){

    let path = NSBundle.mainBundle().pathForResource("change", ofType: "mp3")
    let url = NSURL(fileURLWithPath: path!)
    player = AVAudioPlayer(contentsOfURL: url, error: nil)
    player.prepareToPlay()

  }

  func createViews(){

    self.backgroundColor = UIColor.clearColor()

    emjoView.hidden = true
    emjoView.layer.cornerRadius = CGRectGetHeight(emjoView.frame)/30
    emjoView.userInteractionEnabled = true

    emjoBtn.layer.cornerRadius = CGRectGetWidth(emjoBtn.frame)/2

    textV.borderStyle = UITextBorderStyle.RoundedRect
    textV.delegate = self


  }

  @IBAction func clickedEmjoBtn(sender: UIButton) {
    println("表情按钮")
    sender.selected = !sender.selected
    if sender.selected{
      textV.resignFirstResponder()
    }else{
      textV.becomeFirstResponder()
    }
    emjoView.hidden = !sender.selected
  }

  func itemsWidth()->CGFloat{
    let emjoViewWidth = emjoView.bounds.size.width
    return emjoViewWidth - spaceX * 2
  }

  func itemWidth()->CGFloat{
    var count = arr.count/2
    if arr.count % 2 == 1{
      count = arr.count/2 + 1
    }
    var width = itemsWidth()/CGFloat(count)
    return width
  }
  func itemOfCount()->Int{
    return Int(itemsWidth()/itemWidth())
  }
  func spaceOfY()->CGFloat{

    return (emjoView.bounds.size.height - itemWidth()*2)/2

  }

  func createItems(){
    let row = CGFloat(arr.count/2)
    let emjoViewWidth = emjoView.bounds.size.width
    for i in 0..<arr.count{
      let section = i / itemOfCount()
      let row = i % itemOfCount()
      let item = UIButton.buttonWithType(UIButtonType.Custom)as! UIButton
      item.frame = CGRectMake(spaceX + CGFloat(row) * itemWidth(),spaceOfY() + CGFloat(section) * itemWidth(), itemWidth()*0.9, itemWidth()*0.9)
      item.backgroundColor = UIColor.yellowColor()
      item.layer.cornerRadius = CGRectGetHeight(item.frame)/8
      item.titleLabel?.adjustsFontSizeToFitWidth = true
      item.setTitle(arr[i], forState: .Normal)
      item.setTitleColor(UIColor.blackColor(), forState:.Normal)
      emjoView.addSubview(item)
      item.addTarget(self, action: "clickItem:", forControlEvents: UIControlEvents.TouchUpInside)
    }

  }

  func clickItem(sender:UIButton){
    createSound()
    player.play()

  }



  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    let touch = touches.first as!UITouch
    
    if touch.view.tag == 999{
      return
    }
    emjoView.hidden = true
    textV.resignFirstResponder()
    self.hidden = true
  }
}

extension CKPenInputView: UITextFieldDelegate{
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {

    emjoBtn.selected = false
    return true
  }
}



