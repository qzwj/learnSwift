//: Playground - noun: a place where people can play
// 高级运算符
import UIKit

//除了在之前介绍过的基本运算符，Swift 中还有许多可以对数值进行复杂运算的高级运算符。这些高级运算符包含了在 C 和 Objective-C 中已经被大家所熟知的位运算符和移位运算符。
//与 C 语言中的算术运算符不同，Swift 中的算术运算符默认是不会溢出的。所有溢出行为都会被捕获并报告为错误。如果想让系统允许溢出行为，可以选择使用 Swift 中另一套默认支持溢出的运算符，比如溢出加法运算符（&+）。所有的这些溢出运算符都是以 & 开头的。
//自定义结构体、类和枚举时，如果也为它们提供标准 Swift 运算符的实现，将会非常有用。在 Swift 中自定义运算符非常简单，运算符也会针对不同类型使用对应实现。
//我们不用被预定义的运算符所限制。在 Swift 中可以自由地定义中缀、前缀、后缀和赋值运算符，以及相应的优先级与结合性。这些运算符在代码中可以像预定义的运算符一样使用，我们甚至可以扩展已有的类型以支持自定义的运算符。



// 位运算符
//位运算符可以操作数据结构中每个独立的比特位。它们通常被用在底层开发中，比如图形编程和创建设备驱动。位运算符在处理外部资源的原始数据时也十分有用，比如对自定义通信协议传输的数据进行编码和解码。
//Swift 支持 C 语言中的全部位运算符，接下来会一一介绍。

let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits //0b11110000

// 按位于运算符
//按位与运算符（&）可以对两个数的比特位进行合并。它返回一个新的数，只有当两个数的对应位都为 1 的时候，新数的对应位才为 1

let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let minddleFourBits = firstSixBits & lastSixBits

//按位或运算符
//按位或运算符（|）可以对两个数的比特位进行比较。它返回一个新的数，只要两个数的对应位中有任意一个为 1 时，新数的对应位就为 1
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combineBits = someBits | moreBits


//按位异或运算符 (相同为0, 不同为1)
//按位异或运算符（^）可以对两个数的比特位进行比较。它返回一个新的数，当两个数的对应位不相同时，新数的对应位就为 1：
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits


//按位左移、右移运算符
//按位左移运算符（<<）和按位右移运算符（>>）可以对一个数的所有位进行指定位数的左移和右移，但是需要遵守下面定义的规则。
//对一个数进行按位左移或按位右移，相当于对这个数进行乘以 2 或除以 2 的运算。将一个整数左移一位，等价于将这个数乘以 2，同样地，将一个整数右移一位，等价于将这个数除以 2。
let shiftBits: UInt8 = 4 // 0b00000100
shiftBits << 1
shiftBits << 2
shiftBits << 5
shiftBits << 6
shiftBits << 7
shiftBits >> 2
shiftBits >> 3


//可以使用移位运算对其他的数据类型进行编码和解码：
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16  // redComponent 是 0xCC，即 204
let greenComponent = (pink & 0x00FF00) >> 8 // greenComponent 是 0x66， 即 102
let blueComponent = pink & 0x0000FF         // blueComponent 是 0x99，即 153


//有符号整数的移位运算
//对比无符号整数，有符号整数的移位运算相对复杂得多，这种复杂性源于有符号整数的二进制表现形式。（为了简单起见，以下的示例都是基于 8 比特位的有符号整数的，但是其中的原理对任何位数的有符号整数都是通用的。）
// 向左移动右边都是补0, 但是如果向右移的话, 负数左边就补1, 正数就补0, 右移最终到-1不会在变小
// 左移变大一倍, 右移减小一倍(直到类型的最值)
-8 >> 1
-8 >> 2
-8 >> 3
-8 >> 4
-8 << 1
-8 << 2
-8 << 3
-8 << 4

8 >> 1
8 >> 2
8 >> 3
8 >> 4
8 << 1
8 << 2
8 << 3
8 << 4

//溢出运算符
//在默认情况下，当向一个整数赋予超过它容量的值时，Swift 默认会报错，而不是生成一个无效的数。这个行为为我们在运算过大或着过小的数的时候提供了额外的安全性。
var potentialOverflow = Int16.max
//potentialOverflow += 1 //报错

//为过大或者过小的数值提供错误处理，能让我们在处理边界值时更加灵活。
//然而，也可以选择让系统在数值溢出的时候采取截断处理，而非报错。可以使用 Swift 提供的三个溢出运算符来让系统支持整数溢出运算。这些运算符都是以 & 开头的：
//溢出加法 &+
//溢出减法 &-
//溢出乘法 &*


//数值溢出
//数值有可能出现上溢或者下溢。
//这个示例演示了当我们对一个无符号整数使用溢出加法（&+）进行上溢运算时会发生什么
var unsingedOverflow = UInt8.max
unsingedOverflow = unsingedOverflow &+ 1

var signedOverflow = Int8.min
signedOverflow = signedOverflow &- 1


// 优先级和结合性
// 类似C语言


//运算符函数
//和结构体可以为现有的运算符提供自定义的实现，这通常被称为运算符重载。
//下面的例子展示了如何为自定义的结构体实现加法运算符（+）。算术加法运算符是一个双目运算符，因为它可以对两个值进行运算，同时它还是中缀运算符，因为它出现在两个值中间。
//例子中定义了一个名为 Vector2D 的结构体用来表示二维坐标向量 (x, y)，紧接着定义了一个可以对两个 Vector2D 结构体进行相加的运算符函数：
struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}

//该运算符函数被定义为 Vector2D 上的一个类方法，并且函数的名字与它要进行重载的 + 名字一致。因为加法运算并不是一个向量必需的功能，所以这个类方法被定义在 Vector2D 的一个扩展中，而不是 Vector2D 结构体声明内。而算术加法运算符是双目运算符，所以这个运算符函数接收两个类型为 Vector2D 的参数，同时有一个 Vector2D 类型的返回值。
//在这个实现中，输入参数分别被命名为 left 和 right，代表在 + 运算符左边和右边的两个 Vector2D 实例。函数返回了一个新的 Vector2D 实例，这个实例的 x 和 y 分别等于作为参数的两个实例的 x 和 y 的值之和。
//这个类方法可以在任意两个 Vector2D 实例中间作为中缀运算符来使用
let vector = Vector2D(x: 2.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combineVector = vector + anotherVector
combineVector.x
combineVector.y


//前缀和后缀运算符
//上个例子演示了一个双目中缀运算符的自定义实现。类与结构体也能提供标准单目运算符的实现。单目运算符只运算一个值。当运算符出现在值之前时，它就是前缀的（例如 -a），而当它出现在值之后时，它就是后缀的（例如 b!）。
//要实现前缀或者后缀运算符，需要在声明运算符函数的时候在 func 关键字之前指定 prefix 或者 postfix 修饰符：

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}
let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
negative.x
negative.y


//复合赋值运算符
//复合赋值运算符将赋值运算符（=）与其它运算符进行结合。例如，将加法与赋值结合成加法赋值运算符（+=）。在实现的时候，需要把运算符的左参数设置成 inout 类型，因为这个参数的值会在运算符函数内直接被修改
extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}
var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd
//注意
//不能对默认的赋值运算符（=）进行重载。只有组合赋值运算符可以被重载。同样地，也无法对三目条件运算符 （a ? b : c） 进行重载。


//等价运算符
//自定义的类和结构体没有对等价运算符进行默认实现，等价运算符通常被称为“相等”运算符（==）与“不等”运算符（!=）。对于自定义类型，Swift 无法判断其是否“相等”，因为“相等”的含义取决于这些自定义类型在你的代码中所扮演的角色。
//为了使用等价运算符能对自定义的类型进行判等运算，需要为其提供自定义实现，实现的方法与其它中缀运算符一样：
extension Vector2D {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    static func != (left: Vector2D, right: Vector2D) -> Bool {
        return !(left == right)
    }
}
let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("These two vectors are equivalent.")
}



//自定义运算符
//除了实现标准运算符，在 Swift 中还可以声明和实现自定义运算符。可以用来自定义运算符的字符列表请参考运算符。
//新的运算符要使用 operator 关键字在全局作用域内进行定义，同时还要指定 prefix、infix 或者 postfix 修饰符：
prefix operator +++
//上面的代码定义了一个新的名为 +++ 的前缀运算符。对于这个运算符，在 Swift 中并没有意义，因此我们针对 Vector2D 的实例来定义它的意义。对这个示例来讲，+++ 被实现为“前缀双自增”运算符。它使用了前面定义的复合加法运算符来让矩阵对自身进行相加，从而让 Vector2D 实例的 x 属性和 y 属性的值翻倍。实现 +++ 运算符的方式如下：
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}
var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled



//自定义中缀运算符的优先级
//每个自定义中缀运算符都属于某个优先级组。这个优先级组指定了这个运算符和其他中缀运算符的优先级和结合性。优先级和结合性中详细阐述了这两个特性是如何对中缀运算符的运算产生影响的。
//而没有明确放入优先级组的自定义中缀运算符会放到一个默认的优先级组内，其优先级高于三元运算符。
//以下例子定义了一个新的自定义中缀运算符 +-，此运算符属于 AdditionPrecedence 优先组：
infix operator +-: AdditionPrecedence
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
plusMinusVector.x
plusMinusVector.y
//这个运算符把两个向量的 x 值相加，同时用第一个向量的 y 值减去第二个向量的 y 值。因为它本质上是属于“相加型”运算符，所以将它放置 + 和 - 等默认的中缀“相加型”运算符相同的优先级组中。关于 Swift 标准库提供的运算符，以及完整的运算符优先级组和结合性设置，请参考 Swift Standard Library Operators Reference。而更多关于优先级组以及自定义操作符和优先级组的语法，请参考运算符声明
//注意
//当定义前缀与后缀运算符的时候，我们并没有指定优先级。然而，如果对同一个值同时使用前缀与后缀运算符，则后缀运算符会先参与运算。

