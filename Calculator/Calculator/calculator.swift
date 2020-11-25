//
//  calculator.swift
//  Calculator
//
//  Created by Xutw on 2020/10/23.
//


// 计算器的具体规则 字符串匹配。
import Foundation
struct Stack <T>
{
    public var elements = [T]()
    
    public var count : Int
    {
        return elements.count
    }
    public  mutating func push(element :T)
    {
            self.elements.append(element)
    }
    public mutating func pop() -> T?
    {
            return elements.popLast()
    }
    public func top() -> T?
    {
        return elements.last
    }
    public func empty() -> Bool
    {
        return elements.isEmpty
    }
    
}
func isdigit  (_ ch :Character ) -> Bool
{
    if ch >= "0" && ch <= "9"{
        return true
    }
    else{
        return false
    }
}
func level (_ ch:Character) ->Int
{
    switch ch {
    case "+" :  return 1
    case "-" :  return 1
    case "×" :  return 2
    case "÷" :  return 2
    case "(" :  return 0
    default  :  return 3
    }
}
func  Caculate (text : String) -> String
{
    var opt : Stack<Character> = Stack()
    var last = ""
    /* 将中缀表达式转换成后缀表达式 */
    var num = ""    // 暂存数字
    var state = 0 //1 num存     0 num出
    for c in text
    {
            if isdigit(c) || c == "."
            {
                num += String(c)
                state = 1     // 状态：存数字
            }
            else
            {
                if state == 1
                {        // 数字存过
                    last = last + num
                    //print(num)
                    //print(last)
                    last += "|"
                    //数字存入后缀中 当前数字清空
                    num = ""
                    print(last)
                }
                if c == "("
                {
                    opt.push(element: c)
                }
                else if c == "="
                {
                    break
                }
                else if c == ")"
                {
                    while !opt.empty() && opt.top() != "("
                    {
                        last += String(opt.pop()!)
                        
                    }
                    opt.pop()
                }
                else
                {
                    print("in else")
                    if opt.empty()
                    {
                        opt.push(element: c)
                        print("empty")
                    }
                    else
                    {
                        while true
                        {
                            print("in while")
                            if level(c) > level(opt.top()!)
                            {
                                print("in if")
                                opt.push(element: c)
                                break
                            }
                            else
                            {
                                print("in else")
                                last += String(opt.pop()!)
                                
                                if(opt.empty())
                                {
                                    opt.push(element: c)
                                    break
                                }
                            }
                        }
                    }
                }
                state = 0;    // 状态：在数字外
            }
        
    }
    while true {
        if(!opt.empty())
        {
            last += String(opt.pop()!)
        }
        else
        {
            break
        }
        
    }
    
    print(last + "  over")
    var st : Stack<Float> = Stack()
    var now = ""
        for str in last
        {

            var a : Float = 0
            var b : Float = 0
            switch str {
            case "+":
                a = st.pop()!
                b = st.pop()!
                st.push(element: a + b)
            case "-" :
                a = st.pop()!
                b = st.pop()!
                st.push(element: b - a)
                
            case "×" :
                a = st.pop()!
                b = st.pop()!
                st.push(element: a * b)
            case "÷" :
                a = st.pop()!
                b = st.pop()!
                st.push(element: b / a)
            case "|" :
                st.push(element: Float(now)!)
                now = ""
            default:
                now += String(str)
                
            }
        }
        
    if(st.top()==nil){
        return ""
    }
    return String(st.top()!)
}
