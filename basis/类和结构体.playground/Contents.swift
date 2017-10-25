//: Playground - noun: a place where people can play
// 类和结构体
import UIKit

//类和结构体是人们构建代码所用的一种通用且灵活的构造体。我们可以使用完全相同的语法规则来为类和结构体定义属性（常量、变量）和添加方法，从而扩展类和结构体的功能。
//与其他编程语言所不同的是，Swift 并不要求你为自定义类和结构去创建独立的接口和实现文件。你所要做的是在一个单一文件中定义一个类或者结构体，系统将会自动生成面向其它代码的外部接口。

//类和结构体对比
//Swift 中类和结构体有很多共同点。共同处在于：
//-定义属性用于存储值
//-定义方法用于提供功能
//-定义下标操作使得可以通过下标语法来访问实例所包含的值
//-定义构造器用于生成初始化值
//-通过扩展以增加默认实现的功能
//-实现协议以提供某种标准功能

//与结构体相比，类还有如下的附加功能：
//-继承允许一个类继承另一个类的特征
//-类型转换允许在运行时检查和解释一个类实例的类型
//-析构器允许一个类实例释放任何其所被分配的资源
//-引用计数允许对一个类的多次引用


// 定义语法
class SomeClass { //类
    
}
struct SomeStructure { //结构体
    
}
//注意
//在你每次定义一个新类或者结构体的时候，实际上你是定义了一个新的 Swift 类型。因此请使用UpperCamelCase这种方式来命名（如SomeClass和SomeStructure等），以便符合标准 Swift 类型的大写命名风格（如String，Int和Bool）。相反的，请使用lowerCamelCase这种方式为属性和方法命名（如framerate和incrementCount），以便和类型名区分
// 实例
struct Resolution {
    var width = 0; //会被推断为Int, 以下也是会自动推断
    var height = 0;
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String? //默认为nil
}
let someResolution = Resolution()
let someVideoMode = VideoMode()
print("the width of someResolution is \(someResolution.width)")
print("the width of someVideoMode is \(someVideoMode.resolution.width)")
someVideoMode.resolution.width = 1280
print("the width of someVideoMode is \(someVideoMode.resolution.width)")

//结构体类型的成员逐一构造器
//所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中,编译器不会自动提示这个方法, 需要手动输入
//与结构体不同，类实例没有默认的成员逐一构造器
let vga = Resolution(width: 640, height: 480)
vga.width


// 结构体和枚举是值类型
//值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
//在之前的章节中，我们已经大量使用了值类型。实际上，在 Swift 中，所有的基本类型：整数（Integer）、浮点数（floating-point）、布尔值（Boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，并且在底层都是以结构体的形式所实现。
//在 Swift 中，所有的结构体和枚举类型都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候都会被复制。
let hd = Resolution(width: 123, height: 345)
var hw = hd
hw.width = 111 //不用var, 不能修改
print("hw.width is \(hw.width)")
print("hd.width is \(hd.width)")

enum CompassPoint: String {
    case north, south, west, east
}

var currentPoint = CompassPoint.east
let willPoint = currentPoint
currentPoint = .west
// 只有枚举是原始值的时候才有rawValue的类型
print("willPoint = \(willPoint.rawValue), currentPoint = \(currentPoint)")
// 从上面的结果可以看出, 修改了值, 都不影响另外的一个


// 类是引用类型
//与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，引用的是已存在的实例本身而不是其拷贝。
let a1 = VideoMode()
a1.resolution = hd
a1.interlaced = true
a1.name = "aaa"
a1.frameRate = 21.0
print("a1.name === \(a1.name)")
let a2 = a1
a2.name = "bbb"
print("a1.name === \(a1.name)")
// 虽然a1和a2都是常量, 但是他们都是引用的VideoMode的实例, 修改实例的值, 并不会更改这个引用, 所以常量可以定义为常量
// 和上面值类型不能再常量下改变可以总结出, 引用类型才可以在常量下改变实例的值


// 恒等运算发
//因为类是引用类型，有可能有多个常量和变量在幕后同时引用同一个类实例。（对于结构体和枚举来说，这并不成立。因为它们作为值类型，在被赋予到常量、变量或者传递到函数时，其值总是会被拷贝。）
//如果能够判定两个常量或者变量是否引用同一个类实例将会很有帮助。为了达到这个目的，Swift 内建了两个恒等运算符：
//等价于（===）
//不等价于（!==）
if a1 === a2 {
    print("a1 和 a2 都引用同一个实例")
}
//请注意，“等价于”（用三个等号表示，===）与“等于”（用两个等号表示，==）的不同：
//“等价于”表示两个类类型（class type）的常量或者变量引用同一个类实例。
//“等于”表示两个实例的值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相对于“相等”来说，这是一种更加合适的叫法。

//指针
//如果你有 C，C++ 或者 Objective-C 语言的经验，那么你也许会知道这些语言使用指针来引用内存中的地址。一个引用某个引用类型实例的 Swift 常量或者变量，与 C 语言中的指针类似，但是并不直接指向某个内存地址，也不要求你使用星号（*）来表明你在创建一个引用。Swift 中的这些引用与其它的常量或变量的定义方式相同。


//类和结构体的选择
//在你的代码中，你可以使用类和结构体来定义你的自定义数据类型。
//然而，结构体实例总是通过值传递，类实例总是通过引用传递。这意味两者适用不同的任务。当你在考虑一个工程项目的数据结构和功能的时候，你需要决定每个数据结构是定义成类还是结构体。
//按照通用的准则，当符合一条或多条以下条件时，请考虑构建结构体：
//-该数据结构的主要目的是用来封装少量相关简单数据值。
//-有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
//-该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
//-该数据结构不需要去继承另一个既有类型的属性或者行为。
//-举例来说，以下情境中适合使用结构体：
//
//几何形状的大小，封装一个width属性和height属性，两者均为Double类型。
//*一定范围内的路径，封装一个start属性和length属性，两者均为Int类型。
//*三维坐标系内一点，封装x，y和z属性，三者均为Double类型。
//*在所有其它案例中，定义一个类，生成一个它的实例，并通过引用来管理和传递。实际中，这意味着绝大部分的自定义数据构造都应该是类，而非结构体。


//字符串、数组、和字典类型的赋值与复制行为
//Swift 中，许多基本类型，诸如String，Array和Dictionary类型均以结构体的形式实现。这意味着被赋值给新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。
//Objective-C 中NSString，NSArray和NSDictionary类型均以类的形式实现，而并非结构体。它们在被赋值或者被传入函数或方法时，不会发生值拷贝，而是传递现有实例的引用。

//注意
//以上是对字符串、数组、字典的“拷贝”行为的描述。在你的代码中，拷贝行为看起来似乎总会发生。然而，Swift 在幕后只在绝对必要时才执行实际的拷贝。Swift 管理所有的值拷贝以确保性能最优化，所以你没必要去回避赋值来保证性能最优化。

