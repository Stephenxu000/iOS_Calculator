//
//  ViewController.swift
//  Calculator
//
//  Created by Xutw on 2020/9/28.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK:变量
    var userIsTyping = false//display是否为空 只有写了数字才是true
    var twooperationstimes = 1;//二元运算符不能连续出现
    var left=0 //左括号 数目和右括号相等 记录左括号数目
    var ifdot=0//记录能否输入小数点
    var ifoperator=0//一个数字只能输入一次小数点。每次输入符号+数字后重置
    //MARK:组件
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var result: UITextField!
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
       
        if ifoperator == 1{
            ifdot = 0
            ifoperator = 0
        }
        
        let digit = sender.currentTitle!
//        if display.text?.last == "." && digit == "."
//        {
//            return
//        }
        if ifdot == 1 && digit == "."
        {
            return
        }
        if userIsTyping ||  digit == "."{
            let scan = display.text!
            display.text = scan + digit
            if(digit == ".")
            {
                userIsTyping = true
                ifdot = 1//0.***也是正在书写
            }
        } else {//为空
            display.text = digit
            userIsTyping = true
        }
        if display.text?.last != "."
        {
            twooperationstimes = 1;//最后一位不是小数点即可算
        }
        if(twooperationstimes == 1)
        {
            let nowtext = display.text! +  "="
            result.text = Caculate(text: nowtext)
        }
        twooperationstimes=0;
    }
    
    @IBAction func funcOperation(_ sender: UIButton) {
        
        
        if let funcSymbol = sender.currentTitle {
            switch funcSymbol {
            case "AC":
                userIsTyping = false
                display.text = "0"
                result.text = ""
                twooperationstimes = 1
                ifdot = 0
                ifoperator = 0
            case "Del":
                if display.text != nil
                {
                    if display.text!.count == 1 || display.text==""
                    {
                        userIsTyping = false
                        display.text = "0"
                    }
                    else
                    {
                        if display.text?.last == "+" || display.text?.last == "-"||display.text?.last == "×"||display.text?.last == "÷"{
                            twooperationstimes = 1
                        }
                        else{
                            twooperationstimes = 0
                        }
                        display.text!.removeLast()
                        
                    }
                }
            default:
                break
            }
        }
        
    }
    
    @IBAction func calculateOperation(_ sender: UIButton) {
   
        ifoperator=1;
        let operations = sender.currentTitle!
        if(operations == "="){
            twooperationstimes = 0
            left = 0
            ifdot = 1//结果整形也会转为*.0 默认有小数点
            ifoperator = 0
            //userIsTyping = false 下面预算板块的值会顶上去 只有按ac才是真正的结束书写。
            display.text = Caculate(text: display.text!+"=")
            result.text = ""
        }
        
        else if twooperationstimes == 1 || userIsTyping == false{
           if operations == "(" {
                if userIsTyping {
                left += 1
                display.text! += operations
                }
                else{
                userIsTyping = true
                display.text! = operations
                left += 1
                }
           }
           else if operations == ")" && left>0{
            display.text! += ")"
            let nowtext = display.text! +  "="
            result.text = Caculate(text: nowtext)
            twooperationstimes = 0
            left -= 1
           }
        }
        else if  twooperationstimes < 1 {
            twooperationstimes = 1
            if operations != ")" {
            display.text! += operations
            }
            if operations == ")" && left>0
            {
                display.text! += operations
                let nowtext = display.text! + "="
                result.text = Caculate(text: nowtext)
                twooperationstimes = 0
                left -= 1
            }
        }
    }
  
    
}
