//: Playground - noun: a place where people can play
// 闭包
import UIKit

// 闭包是自包含的函数代码块, 可以在代码中被传递和使用, swift中的闭包与c和oc的blocks比较相似
// 闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为包裹常量和变量。 Swift 会为你管理在捕获过程中涉及到的所有内存操作
// 闭包采取如下三种形式之一：
// 1.全局函数是一个有名字但不会捕获任何值的闭包
// 2.嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
// 3.闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包


// 闭包表达式
// 嵌套函数是一个在较复杂函数中方便进行命名和定义自包含代码模块的方式。当然，有时候编写小巧的没有完整定义和命名的类函数结构也是很有用处的，尤其是在你处理一些函数并需要将另外一些函数作为该函数的参数时。
// 闭包表达式是一种利用简洁语法构建内联闭包的方式。闭包表达式提供了一些语法优化，使得撰写闭包变得简单明了。下面闭包表达式的例子通过使用几次迭代展示了 sorted(by:) 方法定义和语法优化的方式。每一次迭代都用更简洁的方式描述了相同的功能。

// sorted方法
// Swift 标准库提供了名为 sorted(by:) 的方法，它会根据你所提供的用于排序的闭包函数将已知类型数组中的值进行排序。一旦排序完成，sorted(by:) 方法会返回一个与原数组大小相同，包含同类型元素且元素已正确排序的新数组。原数组不会被 sorted(by:) 方法修改。
let names = ["Chirs", "Alex", "Ewa", "Barry", "Daniella"]
//sorted(by:) 方法接受一个闭包，该闭包函数需要传入与数组元素类型相同的两个值，并返回一个布尔类型值来表明当排序结束后传入的第一个参数排在第二个参数前面还是后面。如果第一个参数值出现在第二个参数值前面，排序闭包函数需要返回true，反之返回false。
//该例子对一个 String 类型的数组进行排序，因此排序闭包函数类型需为 (String, String) -> Bool。
//提供排序闭包函数的一种方式是撰写一个符合其类型要求的普通函数，并将其作为 sorted(by:) 方法的参数传入：
func backward(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reverserNames = names.sorted(by: backward)
//然而，以这种方式来编写一个实际上很简单的表达式（a > b)，确实太过繁琐了。对于这个例子来说，利用闭包表达式语法可以更好地构造一个内联排序闭包。

// 1.闭包表达式语法
// 格式如下
//{ (parameters) -> returnType in
//    statements
//}
reverserNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
print(reverserNames)

//2.需要注意的是内联闭包参数和返回值类型声明与 backward(_:_:) 函数类型声明相同。在这两种方式中，都写成了 (s1: String, s2: String) -> Bool。然而在内联闭包表达式中，函数和返回值类型都写在大括号内，而不是大括号外。
//闭包的函数体部分由关键字in引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。
//由于这个闭包的函数体部分如此短，以至于可以将其改写成一行代码：
reverserNames = names.sorted(by: {(s1: String, s2: String) -> Bool in return s1 > s2})
print(reverserNames)

//3.根据上下文推断类型
//因为排序闭包函数是作为 sorted(by:) 方法的参数传入的，Swift 可以推断其参数和返回值的类型。sorted(by:) 方法被一个字符串数组调用，因此其参数必须是 (String, String) -> Bool 类型的函数。这意味着 (String, String) 和 Bool 类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断，返回箭头（->）和围绕在参数周围的括号也可以被省略：
reverserNames = names.sorted(by: {s1, s2 in return s1 > s2})
print(reverserNames)
//实际上，通过内联闭包表达式构造的闭包作为参数传递给函数或方法时，总是能够推断出闭包的参数和返回值类型。这意味着闭包作为函数或者方法的参数时，你几乎不需要利用完整格式构造内联闭包。
//尽管如此，你仍然可以明确写出有着完整格式的闭包。如果完整格式的闭包能够提高代码的可读性，则我们更鼓励采用完整格式的闭包。而在 sorted(by:) 方法这个例子里，显然闭包的目的就是排序。由于这个闭包是为了处理字符串数组的排序，因此读者能够推测出这个闭包是用于字符串处理的。

//4.单表达式闭包隐式返回
//单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为：
reverserNames = names.sorted(by: {s1, s2 in s1 > s2})
print(reverserNames)
//在这个例子中，sorted(by:) 方法的参数类型明确了闭包必须返回一个 Bool 类型值。因为闭包函数体只包含了一个单一表达式（s1 > s2），该表达式返回 Bool 类型值，因此这里没有歧义，return 关键字可以省略。

// 5.参数名称缩写
//Swift 自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0，$1，$2 来顺序调用闭包的参数，以此类推。
//如果你在闭包表达式中使用参数名称缩写，你可以在闭包定义中省略参数列表，并且对应参数名称缩写的类型会通过函数类型进行推断。in关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成：
reverserNames = names.sorted(by: {$0 > $1})
print(reverserNames)

// 6.运算符方法
// 实际上还有一种更简短的方式来编写上面例子中的闭包表达式。Swift 的 String 类型定义了关于大于号（>）的字符串实现，其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。而这正好与 sorted(by:) 方法的参数需要的函数类型相符合。因此，你可以简单地传递一个大于号，Swift 可以自动推断出你想使用大于号的字符串函数实现：
reverserNames = names.sorted(by: >)
print(reverserNames)



// 尾随闭包
//如果你需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，你不用写出它的参数标签：
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数体部分
    closure()
}
// 以下是不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure(closure: {
    // 闭包主体部分
    print("不使用尾随闭包的方法")
})
// 以下是使用尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
    // 闭包主体部分
    print("使用尾随闭包的方法")
}
// 当尾随闭包只有一个参数可以省略最后括号的参数
someFunctionThatTakesAClosure {
    // 闭包主体部分
    print("使用尾随闭包的方法")
}
// 在闭包表达式语法一节中作为 sorted(by:) 方法参数的字符串排序闭包可以改写为：
reverserNames = names.sorted() { $1 > $0 }
print(reverserNames)
//如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉
reverserNames = names.sorted { $0 > $1 }
print(reverserNames)
//当闭包非常长以至于不能在一行中进行书写时，尾随闭包变得非常有用。举例来说，Swift 的 Array 类型有一个 map(_:) 方法，这个方法获取一个闭包表达式作为其唯一参数。该闭包函数会为数组中的每一个元素调用一次，并返回该元素所映射的值。具体的映射方式和返回值类型由闭包来指定。
//当提供给数组的闭包应用于每个数组元素后，map(_:) 方法将返回一个新的数组，数组中包含了与原数组中的元素一一对应的映射后的值。
//下例介绍了如何在 map(_:) 方法中使用尾随闭包将 Int 类型数组 [16, 58, 510] 转换为包含对应 String 类型的值的数组["OneSix", "FiveEight", "FiveOneZero"]：
let digitNames = [0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"]
let numbers = [16, 58, 510]
//如上代码创建了一个整型数位和它们英文版本名字相映射的字典。同时还定义了一个准备转换为字符串数组的整型数组。
//你现在可以通过传递一个尾随闭包给 numbers 数组的 map(_:) 方法来创建对应的字符串版本数组：
let strings = numbers.map { (number) -> String in //(number: Int)可以推断出来
    var num = number
    var output = ""
    while num > 0 {
        output = digitNames[num % 10]! + output
        num /= 10
    }
    return output
}
print(strings)
//map(_:) 为数组中每一个元素调用了一次闭包表达式。你不需要指定闭包的输入参数 number 的类型，因为可以通过要映射的数组类型进行推断。
//在该例中，局部变量 num 的值由闭包中的 number 参数获得，因此可以在闭包函数体内对其进行修改，(闭包或者函数的参数总是常量)，闭包表达式指定了返回类型为 String，以表明存储映射值的新数组类型为 String。
//在上面的例子中，通过尾随闭包语法，优雅地在函数后封装了闭包的具体功能，而不再需要将整个闭包包裹在 map(_:) 方法的括号内。



// 值捕获
//闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。
//Swift 中，可以捕获值的闭包的最简单形式是嵌套函数，也就是定义在其他函数的函数体内的函数。嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
//举个例子，这有一个叫做 makeIncrementer 的函数，其包含了一个叫做 incrementer 的嵌套函数。嵌套函数 incrementer() 从上下文中捕获了两个值，runningTotal 和 amount。捕获这些值之后，makeIncrementer 将 incrementer 作为闭包返回。每次调用 incrementer 时，其会以 amount 作为增量增加 runningTotal 的值。
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
//makeIncrementer 返回类型为 () -> Int。这意味着其返回的是一个函数，而非一个简单类型的值。该函数在每次调用时不接受参数，只返回一个 Int 类型的值。关于函数返回其他函数的内容，请查看函数类型作为返回类型。
//makeIncrementer(forIncrement:) 函数定义了一个初始值为 0 的整型变量 runningTotal，用来存储当前总计数值。该值为 incrementer 的返回值。
//makeIncrementer(forIncrement:) 有一个 Int 类型的参数，其外部参数名为 forIncrement，内部参数名为 amount，该参数表示每次 incrementer 被调用时 runningTotal 将要增加的量。makeIncrementer 函数还定义了一个嵌套函数 incrementer，用来执行实际的增加操作。该函数简单地使 runningTotal 增加 amount，并将其返回。
//如果我们单独考虑嵌套函数 incrementer()，会发现它有些不同寻常：
//func incrementer() -> Int {
//    runningTotal += amount
//    return runningTotal
//}
//incrementer() 函数并没有任何参数，但是在函数体内访问了 runningTotal 和 amount 变量。这是因为它从外围函数捕获了 runningTotal 和 amount 变量的引用。捕获引用保证了 runningTotal 和 amount 变量在调用完 makeIncrementer 后不会消失，并且保证了在下一次执行 incrementer 函数时，runningTotal 依旧存在。
//注意 为了优化，如果一个值不会被闭包改变，或者在闭包创建后不会改变，Swift 可能会改为捕获并保存一份对值的拷贝。 Swift 也会负责被捕获变量的所有内存管理工作，包括释放不再需要的变量。
//该例子定义了一个叫做 incrementByTen 的常量，该常量指向一个每次调用会将其 runningTotal 变量增加 10 的 incrementer 函数。调用这个函数多次可以得到以下结果：
let incrementByTen = makeIncrementer(forIncrement: 11)
let a1 = incrementByTen() // 11
let a2 = incrementByTen() // 22
let a3 = incrementByTen() // 33
//如果你创建了另一个 incrementer，它会有属于自己的引用，指向一个全新、独立的 runningTotal 变量：
let incrementBySeven = makeIncrementer(forIncrement: 7)
let a4 = incrementBySeven() // 7
//注意：
//如果你将闭包赋值给一个类实例的属性，并且该闭包通过访问该实例或其成员而捕获了该实例，你将在闭包和该实例间创建一个循环强引用。Swift 使用捕获列表来打破这种循环强引用。更多信息，请参考闭包引起的循环强引用。



// 闭包是引用类型
//上面的例子中，incrementBySeven 和 incrementByTen 都是常量，但是这些常量指向的闭包仍然可以增加其捕获的变量的值。这是因为函数和闭包都是引用类型。
//无论你将函数或闭包赋值给一个常量还是变量，你实际上都是将常量或变量的值设置为对应函数或闭包的引用。上面的例子中，指向闭包的引用 incrementByTen 是一个常量，而并非闭包内容本身。
//这也意味着如果你将闭包赋值给了两个不同的常量或变量，两个值都会指向同一个闭包：
let alsoIncrementByTen = incrementByTen
let a6 = alsoIncrementByTen() //44

//逃逸闭包
//当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。
//一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。举个例子，很多启动异步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调用。例如：
var completionHandlers: [() -> Void] = [] // 定义一个空数组 type为() -> Void
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
//someFunctionWithEscapingClosure(_:) 函数接受一个闭包作为参数，该闭包被添加到一个函数外定义的数组中。如果你不将这个参数标记为 @escaping，就会得到一个编译错误。
//将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self。比如说，在下面的代码中，传递到 someFunctionWithEscapingClosure(_:) 中的闭包是一个逃逸闭包，这意味着它需要显式地引用 self。相对的，传递到 someFunctionWithNonescapingClosure(_:) 中的闭包是一个非逃逸闭包，这意味着它可以隐式引用 self。
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x)
// 打印出 "200"
completionHandlers.first?()
print(instance.x)
// 打印出 "100"


// 自动闭包
//自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。
//我们经常会调用采用自动闭包的函数，但是很少去实现这样的函数。举个例子来说，assert(condition:message:file:line:) 函数接受自动闭包作为它的 condition 参数和 message 参数；它的 condition 参数仅会在 debug 模式下被求值，它的 message 参数仅当 condition 参数为 false 时被计算求值。
//自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。延迟求值对于那些有副作用（Side Effect）和高计算成本的代码来说是很有益处的，因为它使得你能控制代码的执行时机。下面的代码展示了闭包如何延时求值。
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// 打印出 "5"
let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// 打印出 "5"
print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// 打印出 "4"
//尽管在闭包的代码中，customersInLine 的第一个元素被移除了，不过在闭包被调用之前，这个元素是不会被移除的。如果这个闭包永远不被调用，那么在闭包里面的表达式将永远不会执行，那意味着列表中的元素永远不会被移除。请注意，customerProvider 的类型不是 String，而是 () -> String，一个没有参数且返回值为 String 的函数。
//将闭包作为参数传递给函数时，你能获得同样的延时求值行为。
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// 打印出 "Now serving Alex!"
//上面的 serve(customer:) 函数接受一个返回顾客名字的显式的闭包。下面这个版本的 serve(customer:) 完成了相同的操作，不过它并没有接受一个显式的闭包，而是通过将参数标记为 @autoclosure 来接收一个自动闭包。现在你可以将该函数当作接受 String 类型参数（而非闭包）的函数来调用。customerProvider 参数将自动转化为一个闭包，因为该参数被标记了 @autoclosure 特性。
// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0)) // 直接当做类型为String的参数,而不是闭包来调用
// 打印 "Now serving Ewa!"



// 如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性。@escaping 属性的讲解见上面的逃逸闭包。
// customersInLine i= ["Barry", "Daniella"]
var customerProviders: [() -> String] = [] //闭包数组
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider) // 逃逸特性@escaping: 先返回,后执行闭包
}
collectCustomerProviders(customersInLine.remove(at: 0)) // 加了标注自动闭包@autoclosure, 把String当做参数
collectCustomerProviders(customersInLine.remove(at: 0)) // 本质上还是把闭包添加到了数组里
print("Collected \(customerProviders.count) closures.")
// 打印 "Collected 2 closures."
for customerProvider in customerProviders { // 遍历类型为()->String的数组, 执行闭包函数,输出结果
    print("Now serving \(customerProvider())!")
}
// 打印 "Now serving Barry!"
// 打印 "Now serving Daniella!"
//在上面的代码中，collectCustomerProviders(_:) 函数并没有调用传入的 customerProvider 闭包，而是将闭包追加到了 customerProviders 数组中。这个数组定义在函数作用域范围外，这意味着数组内的闭包能够在函数返回之后被调用。因此，customerProvider 参数必须允许“逃逸”出函数作用域。

