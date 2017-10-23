//: Playground - noun: a place where people can play
// 函数
import UIKit

//在 Swift 中，每个函数都有一个由函数的参数值类型和返回值类型组成的类型。你可以把函数类型当做任何其他普通变量类型一样处理，这样就可以更简单地把函数当做别的函数的参数，也可以从其他函数中返回函数。函数的定义可以写在其他函数定义中，这样可以在嵌套函数范围内实现功能封装。
// 无参无返回值函数
// 严格上来说，虽然没有返回值被定义，greet(person:) 函数依然返回了值。没有定义返回类型的函数会返回一个特殊的Void值。它其实是一个空的元组（tuple），没有任何元素，可以写成()
//func greet1() ->() {
//    print("我是无参无返回值函数")
//}
func greet1()  {
    print("我是无参无返回值函数")
}
// 无参有返回值函数
func greet2() -> String {
    return "我是无参有返回值函数"
}
// 有参无返回值函数
func greet3(person: String) {
    print("hello, \(person)")
}
// 有参有返回值函数
func greet4(person: String) -> String {
    return "hello, \(person)"
}
greet1()
greet2()
greet3(person: "dqy")
greet4(person: "lwj") //有返回值的函数, 在调用时可以被忽略
// 多个参数
func greet5(person1: String, person2: String) {
    print("hello, \(person1), \(person2)")
}
greet5(person1: "dqy", person2: "lwj")

// 多重返回值
func getMaxAndMin1(array: [Int]) -> (max: Int, min: Int) {
    var currentMax = array[0]
    var currentMin = array[0]
    for value in array { //
        if value > currentMax {
            currentMax = value
        }else if value < currentMin {
            currentMin = value
        }
    }
    return (currentMax, currentMin)
}
let m1 = getMaxAndMin1(array: [1,4,0,11,2,3])
print("max = \(m1.max), min = \(m1.min)")

//可选元组返回类型
func getMaxAndMin2(array: [Int]) -> (max: Int, min: Int)? { // 整个元组是可选不是(Int?, Int?)
    if array.isEmpty {return nil}
    var currentMax = array[0]
    var currentMin = array[0]
    for value in array { //
        if value > currentMax {
            currentMax = value
        }else if value < currentMin {
            currentMin = value
        }
    }
    return (currentMax, currentMin)
}
let m2 = getMaxAndMin2(array: [])

// 指定参数标签(为了看起来更有意义)
func greet6(person: String, call relation: String) -> String{
    return "Hello,\(person), my \(relation)"
}
greet6(person: "lwj", call: "brother")

//忽略函数标签
func greet7(_ person:String, relation: String) {
    print("hello,\(person), my \(relation)")
}
greet7("dqy", relation: "baby")

// 默认参数值
// 将不带有默认值的参数放在函数参数列表的最前。一般来说，没有默认值的参数更加的重要，将不带默认值的参数放在最前保证在函数调用时，非默认参数的顺序是一致的，同时也使得相同的函数在不同情况下调用时显得更为清晰
func greet8(relation: String, person: String = "dqy") {
    print("\(person) is my \(relation)")
}
greet8(relation: "baby") //在调用时可以省略默认值
greet8(relation: "me", person: "lwj")

// 可变参数
// 一个函数最多有一个可变参数, 定义的时候跟类型...
func getSum(_ numbers: Int...) -> Int{
    var total: Int = 0
    for num in numbers { // 可以把传入的可变参数numbers当做一个数组
        total += num
    }
    return total
}
let total = getSum(1,2,3,4,5,6)

// 输入输出函数
// 函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误(compile-time error)。这意味着你不能错误地更改参数值。如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters
//定义一个输入输出参数时，在参数定义前加 inout 关键字。一个输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值。
//你只能传递变量给输入输出参数。你不能传入常量或者字面量，因为这些量是不能被修改的。当传入的参数作为输入输出参数时，需要在参数名前加 & 符，表示这个值可以被函数修改。
//注意 输入输出参数不能有默认值，而且可变参数不能用 inout 标记
var s1 = 20
var s2 = 33
print("swap before: s1 = \(s1), s2 = \(s2)")
func swapValue(_ num1: inout Int, _ num2: inout Int) {
    let tmp = num1
    num1 = num2
    num2 = tmp
}
swap(&s1, &s2)
print("swap after: s1 = \(s1), s2 = \(s2)")

// 函数类型
// 每个函数都有种特定的函数类型，函数的类型由函数的参数类型和返回类型组成。
func add(a: Int, b: Int) -> Int { // 函数类型 (Int, Int) -> Int
    return a + b
}
func sub(a: Int, b: Int) -> Int { // 函数类型 (Int, Int) -> Int
    return a - b
}
func printhello(){ //函数类型 () -> Void
    print("hello world")
}

// 使用函数类型
var addFunc1: (Int, Int) -> Int = add
var addFunc2 = add // 可以像变量一样直接推断类型
let add1 = addFunc1(1,2)
addFunc1 = sub // 相同的函数类型可以直接赋值
let add2 = addFunc1(1,2)

// 使用函数类型作为函数参数
//用 (Int, Int) -> Int 这样的函数类型作为另一个函数的参数类型。这样你可以将函数的一部分实现留给函数的调用者来提供
//mathResult(_:_:_:) 函数的作用就是输出另一个适当类型的数学函数的调用结果。它不关心传入函数是如何实现的，只关心传入的函数是不是一个正确的类型。这使得 mathResult(_:_:_:) 能以一种类型安全（type-safe）的方式将一部分功能转给调用者实现
func mathResult(_ oper: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("oper = \(oper(a, b))")
}
mathResult(addFunc1, 3, 4)


// 函数类型作为返回类型
func goResult(_ oper: String) -> (Int, Int) -> Int {
    if oper == "+" { // 字符串相等
        return addFunc2
    }
    return addFunc1
}

var math = goResult("+")
let sum1 = math(1, 2)
math = goResult("-")
let sum2 = math(2,3)

// 嵌套函数
//到目前为止本章中你所见到的所有函数都叫全局函数（global functions），它们定义在全局域中。你也可以把函数定义在别的函数体中，称作 嵌套函数（nested functions）。
//默认情况下，嵌套函数是对外界不可见的，但是可以被它们的外围函数（enclosing function）调用。一个外围函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用。
func testFunc(status: Bool) -> (Int, Int) -> Int{
    func subFunc1(a: Int, b: Int) -> Int {
        return a * b
    }
    func subFunc2(a: Int, b: Int) -> Int {
        return a % b
    }
    return status ? subFunc1 : subFunc2
}
let test = testFunc(status: true)
let at = test(3, 4)
