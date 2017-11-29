//: Playground - noun: a place where people can play
// 控制流
import UIKit

// for-in, 可以遍历 数组, 集合, 字典, 范围, 字符串等
// 遍历数组
for index in ["1", "2", "3"] {
    print(index)
}
// 遍历集合
let set: Set = ["11", "22", "33"]
for obj in set {
    print(obj)
}
// 遍历字典
for (key, value) in ["k1" : "v1", "k2" : "v2"] {
    print("key : \(key), value : \(value)")
}
// 遍历范围
for a in 1...5 {
    print(a)
}
for _ in 1...6 {
    print("lwj")
}
// 遍历字符串
for c in "hello" {
    print(c)
}
// 开区间
for mintue in stride(from: 0, to: 60, by: 5) { // 0-60, 每隔5个输出一次
    print("mintue = \(mintue)")
}
// 闭区间
for hour in stride(from: 0, through: 12, by: 3) {
    print("hour = \(hour)")
}


// while
// while循环从计算一个条件开始。如果条件为true，会重复运行一段语句，直到条件变为false
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
while square < finalSquare { // 直到为false结束循环
    // 掷骰子
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // 根据点数移动
    square += diceRoll
    if square < board.count {
        // 如果玩家还在棋盘上，顺着梯子爬上去或者顺着蛇滑下去
        square += board[square]
    }
}
print("Game over! square = \(square)")
square = 0
repeat { // 先执行一次循环, 到下面判断是否为false
    // 掷骰子
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // 根据点数移动
    square += diceRoll
    if square < board.count {
        // 如果玩家还在棋盘上，顺着梯子爬上去或者顺着蛇滑下去
        square += board[square]
    }
} while square < finalSquare
print("Game over! square = \(square)")


// if else 不在细叙, 强调的是 condition里一定要是Bool类型
if square < 26  {
    print("square is \(square)")
}else if square < 27 {
    print("square is \(square)")
}else if square < 30 {
    print("square is \(square)")
}


// switch
// switch语句会尝试把某个值与若干个模式（pattern）进行匹配。根据第一个匹配成功的模式，switch语句会执行对应的代码。当有可能的情况较多时，通常用switch语句替换if语句
// swift中的switch可以做到其他很多语言做不到的更多功能
// 基本使用
// 默认会自动跳出分支, 也就是在每个分支后面加break(也可以自己主动加), 可以加fallthrough,就会贯穿到下一个分支
// 如果有default分支, 一定要在分支的最后, 所有的分支一定要能涵盖所有的可能出现的情况
// 分支下面不能为空, 类似下面case "b":

let c: Character = "a"
switch c {
case "a":
    print("this is The 'a'")
//    fallthrough
case "s":
//case "b":
    print("this is The 's'")
default:
    print("this is The '\(c)'")
}
// 区间匹配
let score = 88
switch score {
case 0..<20:
    print("very bad score, come on")
case 20..<40:
    print("just a few score, come on")
case 40..<60:
    print("come on, you will pass the exam")
case 60..<80:
    print("come on, you will become better")
case 80...100:
    print("very good")
default:
    print("you are so specail")
}
// 元组
// 像(0,0)可以匹配到前三个分支, 在swift中, 会忽视后面两个分支, 只会匹配第一个分支
let point = (0,0)
//let point = (2,3)
switch point {
case (0, 0):
    print("you are zero")
case (_, 0):
    print("you are x-axis")
case (0, _):
    print("you are y-axis")
default:
    print("you are not axis")
}
// 值绑定
// 可以允许把匹配的值传入分支中当做临时常量或变量, 第三个分支包含了其他所有的情况, 所有可以不用default分支
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("the x is \(x)")
case (0, let y):
    print("this y is \(y)")
case (let x, let y):
    print("the x is \(x), the y is \(y)")
}
// where
// 在匹配case分支时, 满足where子句才会执行这个分支
let aPoint = (2,-2)
switch aPoint {
case (let x, let y) where x == y :
    print("this is func about x = y")
case (let x, let y) where x == -y :
    print("this is func about x = -y")
default: //用default分支满足其他所有情况
    print("no x = y")
}
// 符合匹配
let ac: Character = "a"
switch ac {
case "a", "e", "i", "o", "u":
    print("\(ac) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
   print("\(ac) is a consonant")
default:
    print("this is other char")
}
let bp = (2, 0)
switch bp {
case (let a, 0), (0, let a):
    print("this is axis")
default:
    print("not axis")
}

let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}


// 控制语句转移
// swift中的 continue, break和c语言类似, 不做过多描叙, fallthrough这个上面switch语句中有介绍, 贯穿作用

// 标签的使用
var i = 0
lwj: while i < 10 {
    i+=1
    if i == 5 {
        print("i is \(i)")
        break lwj
    }
}

// guard 语句提前退出, 类似if, 以后具体学习这个guard, 好像挺常用
let dic = ["xiaohong" : "18", "xiaoming" : "22"]
func greet(person:[String: String]) {
    guard let name = person["xiaoming"] else {
        return
    }
    print("xiaoming's age is \(name)")
}
greet(person: dic)


// 检测 API 可用性
//Swift内置支持检查 API 可用性，这可以确保我们不会在当前部署机器上，不小心地使用了不可用的API。
//编译器使用 SDK 中的可用信息来验证我们的代码中使用的所有 API 在项目指定的部署目标上是否可用。如果我们尝试使用一个不可用的 API，Swift 会在编译时报错。
//我们在if或guard语句中使用可用性条件（availability condition)去有条件的执行一段代码，来在运行时判断调用的API是否可用。编译器使用从可用性条件语句中获取的信息去验证，在这个代码块中调用的 API 是否可用。
if #available(iOS 10, macOS 10.12, *) {
    // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
} else {
    // 使用先前版本的 iOS 和 macOS 的 API
}

//以上可用性条件指定，if语句的代码块仅仅在 iOS 10 或 macOS 10.12 及更高版本才运行。最后一个参数，*，是必须的，用于指定在所有其它平台中，如果版本号高于你的设备指定的最低版本，if语句的代码块将会运行。
//在它一般的形式中，可用性条件使用了一个平台名字和版本的列表。平台名字可以是iOS，macOS，watchOS和tvOS——请访问声明属性来获取完整列表。除了指定像 iOS 8 或 macOS 10.10 的大版本号，也可以指定像 iOS 8.3 以及 macOS 10.10.3 的小版本号。
//if #available(platform name version, ..., *) {
////    APIs 可用，语句将执行
//} else {
////    APIs 不可用，语句将不执行
//}





