//: Playground - noun: a place where people can play
// 下标
import UIKit

//下标可以定义在类、结构体和枚举中，是访问集合，列表或序列中元素的快捷方式。可以使用下标的索引，设置和获取值，而不需要再调用对应的存取方法。举例来说，用下标访问一个Array实例中的元素可以写作someArray[index]，访问Dictionary实例中的元素可以写作someDictionary[key]。
//一个类型可以定义多个下标，通过不同索引类型进行重载。下标不限于一维，你可以定义具有多个入参的下标满足自定义类型的需求。


//下标语法
//下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行存取。语法类似于 实例方法语法 和计算型属性语法的混合。与定义实例方法类似，定义下标使用subscript关键字，指定一个或多个输入参数和返回类型；与实例方法不同的是，下标可以设定为读写或只读。这种行为由 getter 和 setter 实现，有点类似计算型属性：
//subscript(index: Int) -> Int {
//    get {
//        // 返回一个适当的 Int 类型的值
//    }
//
//    set(newValue) {
//        // 执行适当的赋值操作
//    }
//}
//newValue的类型和下标的返回类型相同。如同计算型属性，可以不指定 setter 的参数（newValue）。如果不指定参数，setter 会提供一个名为newValue的默认参数。
//如同只读计算型属性，可以省略只读下标的get关键字：
//subscript(index: Int) -> Int {
//    // 返回一个适当的 Int 类型的值
//}


struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
//        get {
//            return multiplier * index
//        }
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six time three is \(threeTimesTable[6])")
//TimesTable例子基于一个固定的数学公式，对threeTimesTable[someIndex]进行赋值操作并不合适，因此下标定义为只读的。

// 下标用法
//下标的确切含义取决于使用场景。下标通常作为访问集合，列表或序列中元素的快捷方式。你可以针对自己特定的类或结构体的功能来自由地以最恰当的方式实现下标。
//例如，Swift 的Dictionary类型实现下标用于对其实例中储存的值进行存取操作。为字典设值时，在下标中使用和字典的键类型相同的键，并把一个和字典的值类型相同的值赋给这个下标：
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
//Swift 的Dictionary类型的下标接受并返回可选类型的值。上例中的numberOfLegs字典通过下标返回的是一个Int?或者说“可选的int”。Dictionary类型之所以如此实现下标，是因为不是每个键都有个对应的值，同时这也提供了一种通过键删除对应值的方式，只需将键对应的值赋值为nil即可。


// 下标选项
//下标可以接受任意数量的入参，并且这些入参可以是任意类型。下标的返回值也可以是任意类型。下标可以使用变量参数和可变参数，但不能使用输入输出参数，也不能给参数设置默认值。
//一个类或结构体可以根据自身需要提供多个下标实现，使用下标时将通过入参的数量和类型进行区分，自动匹配合适的下标，这就是下标的重载。
//虽然接受单一入参的下标是最常见的，但也可以根据情况定义接受多个入参的下标。例如下例定义了一个Matrix结构体，用于表示一个Double类型的二维矩阵。Matrix结构体的下标接受两个整型参数：
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    // 检查越界
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    // 相当于一个实例方法, 可以直接调用其他的函数
    subscript(row: Int, column: Int) -> Double {
        get {
            // 断言调用函数检查越界
            assert(indexIsValid(row: row, column: column), "index out of range")
            return grid[row * columns + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "index out of range")
            grid[row * columns + column] = newValue
        }
    }
}
//Matrix提供了一个接受两个入参的构造方法，入参分别是rows和columns，创建了一个足够容纳rows * columns个Double类型的值的数组。通过传入数组长度和初始值0.0到数组的构造器，将矩阵中每个位置的值初始化为0.0。关于数组的这种构造方法请参考创建一个空数组。
//你可以通过传入合适的row和column的数量来构造一个新的Matrix实例
// 矩阵
// 0, 2.2
// 3.3, 0
// grid = [0, 2.2, 3.3, 0]
var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 2.2
matrix[1, 0] = 3.3
print(matrix.grid)
// 越界
//matrix[2, 2] = 4.4

