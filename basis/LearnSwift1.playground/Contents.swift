//: Playground - noun: a place where people can play

import UIKit

// swift是强类型语言,每一个变量或者常量,都应该有自己确定的类型, 我们在直接在定义字面量的时候, 可以不用添加标识,会自动的推断出其类型
// swift行语句可以不用加分号
// let定义的常量不可以修改, var定义变量
let a: UInt16 = 2_000 // 可以用_符号隔开数据, 更容易观看, 不影响使用
let b: UInt = 1
let c = a + UInt16(b)
let d: UInt8 = 255
let d1 = UInt8.max // UInt8类型的最大值
let e = 3 + 0.1450 // 数字本身属于常量, 没有确定的类型,所以可以直接相加, 如果是定义两个常量,则是明确了数据类似, 需要进行强制转换
let e1 = Int(e)
typealias MyInt = UInt8 //定义别名
let f = MyInt.max
let g = true
if g { // if条件句一定要用bool类型, 不能用非空为真了, 类似 if 1 这样
    print("come on, boy")
}

if 1 == 1 {
    print("just a test")
}


// 元组 (可以放各种不同的数据类型) 下面的例子元组的类型是 (Int, String), 通常用在作为返回值
let errorStatus = (400, "not found")
print(errorStatus.0) // 通过下标访问
print(errorStatus.1)
let (code, des) = errorStatus // 给元组内的字段命名
print(code) // 不能 errorStatus.code
print(des)
let (code1, _) = errorStatus // -符号省略给第二个参数命名
let me = (height: 165, weight: 54, defect: "情商太低, 对不起"); // 在定义元组的时候可以直接给里面的值命名
me.defect
me.height


//  可选类型
//  用来处理值可能缺失的情况, 一种是有值等于x
//  另外一种没有值, C 和 Objective-C 中并没有可选类型这个概念。最接近的是 Objective-C 中的一个特性，一个方法要不返回一个对象要不返回nil，nil表示“缺少一个合法的对象”。然而，这只对对象起作用——对于结构体，基本的 C 类型或者枚举类型不起作用。对于这些类型，Objective-C 方法一般会返回一个特殊值（比如NSNotFound）来暗示值缺失。这种方法假设方法的调用者知道并记得对特殊值进行判断。然而，Swift 的可选类型可以让你暗示任意类型的值缺失，并不需要一个特殊值。
//  swift的Int类型有一种构造器可以将String类型转化为Int类型, 但是只能将"123"转为123, 不能讲"test" 转换成功, 所以如下
let possibleNum = "123"
let realVal = Int(possibleNum) // 这个时候, realVal就会被编译器推断为可选类型, 因为possibleNum可能为nil, 可能为Int类型的数字, 只有这两种情况, 这就是可选类型 Int? 不是Int, 我们在定义的时候可以, let realVal: Int? = Int(possibleNum)


// nil
// 用来给可选类型赋值, 表示其没有值
// nil不能用于非可选的常量和变量。如果你的代码中有常量或者变量需要处理值缺失的情况，请把它们声明成对应的可选类型。
// Swift 的 nil 和 Objective-C 中的 nil 并不一样。在 Objective-C 中，nil 是一个指向不存在对象的指针。在 Swift 中，nil 不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为 nil，不只是对象类型。
var nil_test: Int? = 111
nil_test = nil
var str: String? //声明一个可选类型没有赋值, 会被自动赋值为nil


// if 语句以及强制解析
// 可以使用if 条件句判断可选类型是否为空
let possibleNum1: Int? = 520;
if possibleNum1 != nil {
    print("possibleNum1 不为nil")
}
// 当确定可选类型确实包含值之后，可以在可选的名字后面加一个感叹号（!）来获取值。这个惊叹号表示“我知道这个可选有值，请使用它。”这被称为可选值的强制解析（forced unwrapping）
// 注意：使用 ! 来获取一个不存在的可选值会导致运行时错误。使用 ! 来强制解析值之前，一定要确定可选包含一个非 nil 的值。
if possibleNum1 != nil {
    print("possibleNum1 is \(possibleNum1!)")
}


// 可选绑定
// 使用可选绑定（optional binding）来判断可选类型是否包含值，如果包含就把值赋给一个临时常量或者变量。可选绑定可以用在 if 和 while 语句中，这条语句不仅可以用来判断可选类型中是否有值，同时可以将可选类型中的值赋给一个常量或者变量。if 和 while 语句
var optionVal: String? = "I love you so much";
//optionVal = nil;
if let name = optionVal { // 这个就是可选绑定, optionVal一定要是可选类型
    print("optionVal 可选类型的值不为nil 为 \(name)")
}else{
    print("optionVal 可选类型为nil")
}
// 这段代码可以被理解为：
// “如果可选类型optionVal 包含一个值，创建一个叫做 name 的新常量并将可选包含的值赋给它。”
// 如果转换成功，name 常量可以在 if 语句的第一个分支中使用。它已经被可选类型 包含的 值初始化过，所以不需要再使用 ! 后缀来获取它的值。在这个例子中，name 只被用来输出转换结果。
// 你可以在可选绑定中使用常量和变量。如果你想在if语句的第一个分支中操作 name 的值，你可以改成 if var name，这样可选类型包含的值就会被赋给一个变量而非常量。

// 你可以包含多个可选绑定或多个布尔条件在一个 if 语句中，只要使用逗号分开就行。只要有任意一个可选绑定的值为nil，或者任意一个布尔条件为false，则整个if条件判断为false，这时你就需要使用嵌套 if 条件语句来处理，
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}


//隐式解析可选类型
//如上所述，可选类型暗示了常量或者变量可以“没有值”。可选可以通过 if 语句来判断是否有值，如果有值的话可以通过可选绑定来解析值。
//有时候在程序架构中，第一次被赋值之后，可以确定一个可选类型_总会_有值。在这种情况下，每次都要判断和解析可选值是非常低效的，因为可以确定它总会有值。
//这种类型的可选状态被定义为隐式解析可选类型（implicitly unwrapped optionals）。把想要用作可选的类型的后面的问号（String?）改成感叹号（String!）来声明一个隐式解析可选类型。
//当可选类型被第一次赋值之后就可以确定之后一直有值的时候，隐式解析可选类型非常有用。隐式解析可选类型主要被用在 Swift 中类的构造过程中，请参考无主引用以及隐式解析可选属性。
//一个隐式解析可选类型其实就是一个普通的可选类型，但是可以被当做非可选类型来使用，并不需要每次都使用解析来获取可选值。下面的例子展示了可选类型 String 和隐式解析可选类型 String 之间的区别
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要感叹号来获取值

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString  // 不需要感叹号
//你可以把隐式解析可选类型当做一个可以自动解析的可选类型。你要做的只是声明的时候把感叹号放到类型的结尾，而不是每次取值的可选名字的结尾。
//注意: 如果你在隐式解析可选类型没有值的时候尝试取值，会触发运行时错误。和你在没有值的普通可选类型后面加一个惊叹号一样。

//你仍然可以把隐式解析可选类型当做普通可选类型来判断它是否包含值：
if assumedString != nil {
    print(assumedString)
}
// 输出 "An implicitly unwrapped optional string."
// 你也可以在可选绑定中使用隐式解析可选类型来检查并解析它的值：
if let definiteString = assumedString {
    print(definiteString)
}
// 输出 "An implicitly unwrapped optional string."
// 注意：
// 如果一个变量之后可能变成nil的话请不要使用隐式解析可选类型。如果你需要在变量的生命周期中判断是否是nil的话，请使用普通可选类型。



// 错误处理
// 你可以使用 错误处理（error handling） 来应对程序执行中可能会遇到的错误条件。
// 相对于可选中运用值的存在与缺失来表达函数的成功与失败，错误处理可以推断失败的原因，并传播至程序的其他部分。
// 当一个函数遇到错误条件，它能报错。调用函数的地方能抛出错误消息并合理处理。
func canThrowAnError() throws {
    // 这个函数可能会抛出错误
}
// 一个函数可以通过在声明中添加throws关键词来抛出错误消息。当你的函数能抛出错误消息时, 你应该在表达式中前置try关键词。
// 一个do语句创建了一个新的包含作用域,使得错误能被传播到一个或多个catch从句
do{
    try canThrowAnError()
    // 没有错误抛出
}catch {
    // 抛出了一个错误
}


//断言和先决条件
//断言和先决条件是在运行时所做的检查。你可以用他们来检查在执行后续代码之前是否一个必要的条件已经被满足了。如果断言或者先决条件中的布尔条件评估的结果为 true（真），则代码像往常一样继续执行。如果布尔条件评估结果为false（假），程序的当前状态是无效的，则代码执行结束，应用程序中止。
//你使用断言和先决条件来表达你所做的假设和你在编码时候的期望。你可以将这些包含在你的代码中。断言帮助你在开发阶段找到错误和不正确的假设，先决条件帮助你在生产环境中探测到存在的问题。
//除了在运行时验证你的期望值，断言和先决条件也变成了一个在你的代码中的有用的文档形式。和在上面讨论过的错误处理不同，断言和先决条件并不是用来处理可以恢复的或者可预期的错误。因为一个断言失败表明了程序正处于一个无效的状态，没有办法去捕获一个失败的断言。
//使用断言和先决条件不是一个能够避免出现程序出现无效状态的编码方法。然而，如果一个无效状态程序产生了，断言和先决条件可以强制检查你的数据和程序状态，使得你的程序可预测的中止（译者：不是系统强制的，被动的中止），并帮助使这个问题更容易调试。一旦探测到无效的状态，执行则被中止，防止无效的状态导致的进一步对于系统的伤害。
//断言和先决条件的不同点是，他们什么时候进行状态检测：断言仅在调试环境运行，而先决条件则在调试环境和生产环境中运行。在生产环境中，断言的条件将不会进行评估。这个意味着你可以使用很多断言在你的开发阶段，但是这些断言在生产环境中不会产生任何影响。

//你可以调用 Swift 标准库的 assert(_:_:file:line:) 函数来写一个断言。向这个函数传入一个结果为 true 或者 false 的表达式以及一条信息，当表达式的结果为 false 的时候这条信息会被显示
var age = 5
// 因为 age < 0，所以断言会触发
assert(age >= 0, "A person's age cannot be less than zero")
//在这个例子中，只有 age >= 0 为 true 时，即 age 的值非负的时候，代码才会继续执行。如果 age 的值是负数，就像代码中那样，age >= 0 为 false，断言被触发，终止应用。
//如果不需要断言信息，可以就像这样忽略掉：
assert(age >= 0)

//以下不用断言自己检查条件, 这种断言只需要表明失败
//如果代码已经检查了条件，你可以使用 assertionFailure(_:file:line:)函数来表明断言失败了，例如：
//age = -1

if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age > 0 {
    print("You can ride the ferris wheel.")
} else {
    assertionFailure("A person's age can't be less than zero.")
}

//强制执行先决条件
//当一个条件可能为false（假），但是继续执行代码要求条件必须为true（真）的时候，需要使用先决条件。例如使用先决条件来检查是否下标越界，或者来检查是否将一个正确的参数传给函数。
//你可以使用全局 precondition(_:_:file:line:) 函数来写一个先决条件。向这个函数传入一个结果为 true 或者 false 的表达式以及一条信息，当表达式的结果为 false 的时候这条信息会被显示：
// 在一个下标的实现里...
let index = 23
precondition(index > 0, "Index must be greater than zero.")
//你可以调用　precondition(_:_:file:line:)方法来表明出现了一个错误，例如，switch 进入了 default 分支，但是所有的有效值应该被任意一个其他分支（非 default 分支）处理。
//注意：
//如果你使用unchecked模式（-Ounchecked）编译代码，先决条件将不会进行检查。编译器假设所有的先决条件总是为true（真），他将优化你的代码。然而，fatalError(_:file:line:)函数总是中断执行，无论你怎么进行优化设定。
//你能使用 fatalError(_:file:line:)函数在设计原型和早期开发阶段，这个阶段只有方法的声明，但是没有具体实现，你可以在方法体中写上fatalError("Unimplemented")作为具体实现。因为fatalError不会像断言和先决条件那样被优化掉，所以你可以确保当代码执行到一个没有被实现的方法时，程序会被中断。








