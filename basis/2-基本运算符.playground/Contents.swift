//: Playground - noun: a place where people can play
// 运算符
// 与 C 语言和 Objective-C 不同的是，Swift 默认情况下不允许在数值运算中出现溢出情况。但是你可以使用 Swift 的溢出运算符来实现溢出运算（如 a &+ b）。
import UIKit
// 大部分的运算符和其他高级语言类似, 以下都是特殊指明的


// 加法运算符 (字符可以直接相加, 类似java的)
let str = "hello" + " world"

// 空合运算符
// 空合运算符（a ?? b）将对可选类型 a 进行空判断，如果 a 包含一个值就进行解封，否则就返回一个默认值 b。表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致。
let a: Int? = 4
let c = a ?? 4
//空合运算符是对以下代码的简短表达方法：明显上面的方式更优雅
let c2 = a != nil ? a! : 4

// 区间运算符
// 闭区间运算符: 闭区间运算符（a...b）定义一个包含从 a 到 b（包括 a 和 b）的所有值的区间。a 的值不能超过 b。 ‌ 闭区间运算符在迭代一个区间的所有值时是非常有用的，如在 for-in 循环中
for index in 1...5 {
    print("index is \(index)")
}
// 半开区间运算符: 半开区间运算符（a..<b）定义一个从 a 到 b 但不包括 b 的区间。 之所以称为半开区间，是因为该区间包含第一个值而不包括最后的值。
for index in 1..<5 {
    print("index is \(index)")
}
let aa = "a"..."z"
if aa.contains("bc1") {
    print("哈哈")
}

// swift4特性
let range = 1...
let arr = [1, 2, 3, 4]
for a in arr[1...] {
    print(a)
}

