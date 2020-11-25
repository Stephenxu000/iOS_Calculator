import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    

    var userIsInTheMiddleOfTypingANumber:Bool = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        print("digit = \(digit)")
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber
        {
            enter()
        }
        
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0)}
        default: break
        }


    }
    
    // 定义一个方法用来进行加减乘除运算,参数类型是一个方法:(Double, Double)->Double
    func performOperation(operation:(Double,Double) -> Double) {
        if operandStack.count >= 2 {  // 栈中必须有两个元素才能进行加减乘除的运算
            // 把最后的两个元素分别出栈,然后进行运算
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    // 添加private,不让Swift编译器将其暴露给Objective-C运行时
    private func performOperation(operation:(Double) -> Double)  {
        // 栈中必须多于一个元素才能进行开平方
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = [Double]()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        
        operandStack.append(displayValue)
        
        print("operandStack = \(operandStack)")
        

    }
    
    // 用来进栈的数据
    var displayValue:Double {
        get {
            // 将字符串转换为double
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            // 将value转换成字符串
            display.text = "\(newValue)"
            // 设置重新开始输入字符串
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}
