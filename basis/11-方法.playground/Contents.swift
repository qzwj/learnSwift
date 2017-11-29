//: Playground - noun: a place where people can play
// 方法
import UIKit

//方法是与某些特定类型相关联的函数。类、结构体、枚举都可以定义实例方法；实例方法为给定类型的实例封装了具体的任务与功能。类、结构体、枚举也可以定义类型方法；类型方法与类型本身相关联。类型方法与 Objective-C 中的类方法（class methods）相似。
//结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。在 Objective-C 中，类是唯一能定义方法的类型。但在 Swift 中，你不仅能选择是否要定义一个类/结构体/枚举，还能灵活地在你创建的类型（类/结构体/枚举）上定义方法


// 实例方法
//实例方法是属于某个特定类、结构体或者枚举类型实例的方法。实例方法提供访问和修改实例属性的方法或提供与实例目的相关的功能，并以此来支撑实例的功能。实例方法的语法与函数完全一致
//实例方法要写在它所属的类型的前后大括号之间。实例方法能够隐式访问它所属类型的所有的其他实例方法和属性。实例方法只能被它所属的类的某个特定实例调用。实例方法不能脱离于现存的实例而被调用。
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
//    func increment() {
//        self.count += 1
//    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter()
counter.increment()
counter.increment(by: 22)
counter.reset()


// self属性
//类型的每一个实例都有一个隐含属性叫做self，self完全等同于该实例本身。你可以在一个实例的实例方法中使用这个隐含的self属性来引用当前实例。
// 上面的例子还可以这么写
//    func increment() {
//        self.count += 1
//    }
//使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下，参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时你可以使用self属性来区分参数名称和属性名称。
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x //这里只能用self区分
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(x: 1.0)  {
    print("yes")
}


// 在实例方法中修改值类型
//结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
//但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择可变(mutating)行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的self属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
//要使用可变方法，将关键字mutating 放到方法的func关键字之前就可以了：
struct Point1 {
    var x = 0.0, y = 0.0
    mutating func moveByX(x: Double, y: Double) {
        self.x += x
        self.y += y
        // 在可变方法中给self赋值
//        self = Point1(x: self.x + x, y : self.y + y)
    }
}

var point = Point1(x: 1.0, y: 2.0)
point.moveByX(x: 2.0, y: 3.0)
print("point.x = \(point.x), point.y = \(point.y)")

enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()


// 类型方法 (类方法)
// 和类型属性一样用static和class修饰, static可以修饰struct, enum, class, 但是class只能修饰类继承父类重写实现
//实例方法是被某个类型的实例调用的方法。你也可以定义在类型本身上调用的方法，这种方法就叫做类型方法。在方法的func关键字之前加上关键字static，来指定类型方法。类还可以用关键字class来允许子类重写父类的方法实现。
//注意
//在 Objective-C 中，你只能为 Objective-C 的类类型（classes）定义类型方法（type-level methods）。在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含
class SomeClass {
    class func someTypeMethod() {
        print("我是类型方法")
        // 这里的self值类本身, 不是指实例
    }
}
SomeClass.someTypeMethod()
//在类型方法的方法体（body）中，self指向这个类型本身，而不是类型的某个实例。这意味着你可以用self来消除类型属性和类型方法参数之间的歧义（类似于我们在前面处理实例属性和实例方法参数时做的那样）。
//一般来说，在类型方法的方法体中，任何未限定的方法和属性名称，可以被本类中其他的类型方法和类型属性引用。一个类型方法可以直接通过类型方法的名称调用本类中的其它类型方法，而无需在方法名称前面加上类型名称。类似地，在结构体和枚举中，也能够直接通过类型属性的名称访问本类中的类型属性，而不需要前面加上类型名称

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
   
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel // 直接访问
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) { // 调用isUnlocked方法只是为了验证类型方法的调用,其实可以直接调用里面的类型属性判断
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}
var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// 打印 "highest unlocked level is now 2"
player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
// 打印 "level 6 has not yet been unlocked"

