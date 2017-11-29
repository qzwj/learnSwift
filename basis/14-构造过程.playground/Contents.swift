//: Playground - noun: a place where people can play
// 构造过程
// http://wiki.jikexueyuan.com/project/swift/chapter2/14_Initialization.html
import UIKit

//简单构造器
//注意
//如果一个属性总是使用相同的初始值，那么为其设置一个默认值比每次都在构造器中赋值要好。两种方法的效果是一样的，只不过使用默认值让属性的初始化和声明结合得更紧密。使用默认值能让你的构造器更简洁、更清晰，且能通过默认值自动推导出属性的类型；同时，它也能让你充分利用默认构造器、构造器继承等特性，后续章节将讲到。
struct Fahrenhei {
    var temperature: Double
//    var temperature: Double = 32.0
    init() {
        temperature = 32.0
    }
}
var f = Fahrenhei()
print("the default temperature is \(f.temperature)")



// 跟函数和方法参数相同，构造参数也拥有一个在构造器内部使用的参数名字和一个在调用构造器时使用的外部参数名字。
//然而，构造器并不像函数和方法那样在括号前有一个可辨别的名字。因此在调用构造器时，主要通过构造器中的参数名和类型来确定应该被调用的构造器。正因为参数如此重要，如果你在定义构造器时没有提供参数的外部名字，Swift 会为构造器的每个参数自动生成一个跟内部名字相同的外部名。
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}
//let veryGreen = Color(0.0, 1.0, 0.0) // 报编译时错误，需要外部名称
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

//不带外部名的构造器参数
//如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线(_)来显式描述它的外部名，以此重写上面所说的默认行为。
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ haha: Double) {
        temperatureInCelsius = haha + 200
    }
}
let bodyTemperature = Celsius(37.0)
// bodyTemperature.temperatureInCelsius 为 37.0


//可选属性类型
//如果你定制的类型包含一个逻辑上允许取值为空的存储型属性——无论是因为它无法在初始化时赋值，还是因为它在之后某个时间点可以赋值为空——你都需要将它定义为可选类型。可选类型的属性将自动初始化为nil，表示这个属性是有意在初始化时设置为空的。
class SurveyQuestion {
    let text: String // 定义后不能改变
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."


//默认构造器
//如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器（default initializers）。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例。
class ShoppingListItem1 {
    var name: String?
    var quantity = 1
    var purchased = false

}
var item = ShoppingListItem1()
//由于ShoppingListItem类中的所有属性都有默认值，且它是没有父类的基类，它将自动获得一个可以为所有属性设置默认值的默认构造器（尽管代码中没有显式为name属性设置默认值，但由于name是可选字符串类型，它将默认设置为nil）。上面例子中使用默认构造器创造了一个ShoppingListItem类的实例（使用ShoppingListItem()形式的构造器语法），并将其赋值给变量item。


//结构体的逐一成员构造器
//除了上面提到的默认构造器，如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器，即使结构体的存储型属性没有默认值。
//逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法。我们在调用逐一成员构造器时，通过与成员属性名相同的参数名进行传值来完成对成员属性的初始赋值。
//结构体Size自动获得了一个逐一成员构造器init(width:height:)。你可以用它来为Size创建新的实例：
struct Size {
    var width = 0.0
    var height = 0.0 //,width: Double
//    init(){
//        self.width = 30.0
//        self.height = 40.0
//    }
}


let twoByTwo = Size(width: 2.0, height: 2.0)
twoByTwo.width


//值类型的构造器代理
//构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能减少多个构造器间的代码重复。
//构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型（结构体和枚举类型）不支持继承，所以构造器代理的过程相对简单，因为它们只能代理给自己的其它构造器。类则不同，它可以继承自其它类（请参考继承），这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。这些责任将在后续章节类的继承和构造过程中介绍。
//对于值类型，你可以使用self.init在自定义的构造器中引用相同类型中的其它构造器。并且你只能在构造器内部调用self.init。
//如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器（如果是结构体，还将无法访问逐一成员构造器）。这种限制可以防止你为值类型增加了一个额外的且十分复杂的构造器之后,仍然有人错误的使用自动生成的构造器
//注意
//假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中。想查看更多内容，请查看扩展章节
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point() //默认初始化, 属性一定要有默认值
    var size = Size()

    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                      size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))

//类的继承和构造过程
//类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。
//Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们分别是指定构造器和便利构造器。
//指定构造器和便利构造器
//指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。
//每一个类都必须拥有至少一个指定构造器。在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个条件。具体内容请参考后续章节构造器的自动继承。
//便利构造器是类中比较次要的、辅助型的构造器。你可以定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入值的实例。
//你应当只在必要的时候为类提供便利构造器，比方说某种情况下通过使用便利构造器来快捷调用某个指定构造器，能够节省更多开发时间并让类的构造过程更清晰明了。


//指定构造器和便利构造器的语法
//类的指定构造器的写法跟值类型简单构造器一样：
//init(parameters) {
//    statements
//}
//便利构造器也采用相同样式的写法，但需要在init关键字之前放置convenience关键字，并使用空格将它们俩分开：
//convenience init(parameters) {
//    statements
//}
//
//类的构造器代理规则
//为了简化指定构造器和便利构造器之间的调用关系，Swift 采用以下三条规则来限制构造器之间的代理调用：
//规则 1
//指定构造器必须调用其直接父类的的指定构造器。
//规则 2
//便利构造器必须调用同类中定义的其它构造器。
//规则 3
//便利构造器必须最终导致一个指定构造器被调用。
//一个更方便记忆的方法是：
//指定构造器必须总是向上代理
//便利构造器必须总是横向代理



//构造器的继承和重写
//跟 Objective-C 中的子类不同，Swift 中的子类默认情况下不会继承父类的构造器。Swift 的这种机制可以防止一个父类的简单构造器被一个更精细的子类继承，并被错误地用来创建子类的实例。
//注意
//父类的构造器仅会在安全和适当的情况下被继承。具体内容请参考后续章节构造器的自动继承。
//假如你希望自定义的子类中能提供一个或多个跟父类相同的构造器，你可以在子类中提供这些构造器的自定义实现。
//
//当你在编写一个和父类中指定构造器相匹配的子类构造器时，你实际上是在重写父类的这个指定构造器。因此，你必须在定义子类构造器时带上override修饰符。即使你重写的是系统自动提供的默认构造器，也需要带上override修饰符，具体内容请参考默认构造器。
//正如重写属性，方法或者是下标，override修饰符会让编译器去检查父类中是否有相匹配的指定构造器，并验证构造器参数是否正确。
//注意
//当你重写一个父类的指定构造器时，你总是需要写override修饰符，即使你的子类将父类的指定构造器重写为了便利构造器。
//相反，如果你编写了一个和父类便利构造器相匹配的子类构造器，由于子类不能直接调用父类的便利构造器（每个规则都在上文类的构造器代理规则有所描述），因此，严格意义上来讲，你的子类并未对一个父类构造器提供重写。最后的结果就是，你在子类中“重写”一个父类便利构造器时，不需要加override前缀。
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheels"
    }
}
let vehicle = Vehicle()
vehicle.description

class Bicycle: Vehicle {
    override init() { //重写默认的父类默认的构造器
        super.init()
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
bicycle.numberOfWheels



//重要
//构造器的自动继承
//如上所述，子类在默认情况下不会继承父类的构造器。但是如果满足特定条件，父类构造器是可以被自动继承的。在实践中，这意味着对于许多常见场景你不必重写父类的构造器，并且可以在安全的情况下以最小的代价继承父类的构造器。
//假设你为子类中引入的所有新属性都提供了默认值，以下 2 个规则适用：
//规则 1
//如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。
//规则 2
//如果子类提供了所有父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将自动继承所有父类的便利构造器。
//即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。
//注意
//对于规则 2，子类可以将父类的指定构造器实现为便利构造器。
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "骨头汤")
    }
}
let namedMeat = Food(name: "Bacon")
namedMeat.name

class RecipeIngredient: Food {
    var quantity: Int//如果给这个变量赋值就可以自动继承父类的构造器
    init(name: String, quantity: Int) {
        self.quantity = quantity //先给自己新增的变量初始化
        super.init(name: name) // 调用父类的指定构造器初始化,向上继承
    }
    override convenience init(name: String) { //重写父类的指定构造器为便利构造器
//        self.quantity = 2
        self.init(name: name, quantity: 1) //便利构造器只能调用同类中其它的构造方法
    }
    //这个类重父类的所有指定构造器,尽管重写为了便利构造器,根据规则2,所以这个会继承父类的所有构造器
}


let oneMysterItem = RecipeIngredient() //调用父类的遍历构造器, 调用子类的init(name:)方法.不是调用父类的
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "eggs", quantity: 6)
oneMysterItem.name
oneMysterItem.quantity
oneBacon.quantity
sixEggs.quantity


// 为所有的变量都提供了默认值, 并且没有定义任何构造器, 继承父类所有的指定和便利构造器
class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var descrpition: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "对" : "错"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.descrpition)
}



//可失败构造器
//如果一个类、结构体或枚举类型的对象，在构造过程中有可能失败，则为其定义一个可失败构造器。这里所指的“失败”是指，如给构造器传入无效的参数值，或缺少某种所需的外部资源，又或是不满足某种必要的条件等。
//为了妥善处理这种构造过程中可能会失败的情况。你可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法为在init关键字后面添加问号(init?)。
//注意
//可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同。
//可失败构造器会创建一个类型为自身类型的可选类型的对象。你通过return nil语句来表明可失败构造器在何种情况下应该“失败”。
//注意
//严格来说，构造器都不支持返回值。因为构造器本身的作用，只是为了确保对象能被正确构造。因此你只是用return nil表明可失败构造器构造失败，而不要用关键字return来表明构造成功。
let wholeNumber: Double = 12345.0
let pi = 3.14159

//Int(wholeNumber)这个是强制转换, 下面的Int(exactly:)是可失败构造函数, 小数部分不为0,会返回nil
if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(valueMaintained) conversion to Int maintains value")
}
let valueChanged = Int(exactly: pi)
// valueChanged 是 Int? 类型, 不是 Int 类型
if valueChanged == nil {
    print("\(pi) conversion to Int does not maintain value")
}

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil } //只能返回失败的情况,不能返回成功的情况
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}

//枚举类型的可失败构造器
//你可以通过一个带一个或多个参数的可失败构造器来获取枚举类型中特定的枚举成员。如果提供的参数无法匹配任何枚举成员，则构造失败。
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
//你可以利用该可失败构造器在三个枚举成员中获取一个相匹配的枚举成员，当参数的值不能与任何枚举成员相匹配时，则构造失败：

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// 打印 "This is a defined temperature unit, so initialization succeeded."

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}
// 打印 "This is not a defined temperature unit, so initialization failed."


//带原始值的枚举类型的可失败构造器
//
//带原始值的枚举类型会自带一个可失败构造器init?(rawValue:)，该可失败构造器有一个名为rawValue的参数，其类型和枚举类型的原始值类型一致，如果该参数的值能够和某个枚举成员的原始值匹配，则该构造器会构造相应的枚举成员，否则构造失败。
//
//因此上面的TemperatureUnit的例子可以重写为：

enum TemperatureUnit1: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit1 = TemperatureUnit1(rawValue: "F")
if fahrenheitUnit1 != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// 打印 "This is a defined temperature unit, so initialization succeeded."

let unknownUnit1 = TemperatureUnit1(rawValue: "X")
if unknownUnit1 == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}
// 打印 "This is not a defined temperature unit, so initialization failed."



//构造失败的传递
//类，结构体，枚举的可失败构造器可以横向代理到类型中的其他可失败构造器。类似的，子类的可失败构造器也能向上代理到父类的可失败构造器。
//无论是向上代理还是横向代理，如果你代理到的其他可失败构造器触发构造失败，整个构造过程将立即终止，接下来的任何构造代码不会再被执行。
//注意
//可失败构造器也可以代理到其它的非可失败构造器。通过这种方式，你可以增加一个可能的失败状态到现有的构造过程中。
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}
if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// 打印 "Item: sock, quantity: 2"
//倘若你以一个值为 0 的 quantity 来创建一个 CartItem 实例，那么将导致 CartItem 构造器失败：

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
// 打印 "Unable to initialize zero shirts"
//同样地，如果你尝试传入一个值为空字符串的 name来创建一个 CartItem 实例，那么将导致父类 Product 的构造过程失败：

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}
// 打印 "Unable to initialize one unnamed product"




//重写一个可失败构造器
//如同其它的构造器，你可以在子类中重写父类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个父类的可失败构造器。这使你可以定义一个不会构造失败的子类，即使父类的构造器允许构造失败。
//注意，当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。
//注意
//你可以用非可失败构造器重写可失败构造器，但反过来却不行。
//下例定义了一个名为Document的类，name属性的值必须为一个非空字符串或nil，但不能是一个空字符串：

class Document {
    var name: String?
    // 该构造器创建了一个 name 属性的值为 nil 的 document 实例
    init() {}
    // 该构造器创建了一个 name 属性的值为非空字符串的 document 实例
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}
//下面这个例子，定义了一个Document类的子类AutomaticallyNamedDocument。这个子类重写了父类的两个指定构造器，确保了无论是使用init()构造器，还是使用init(name:)构造器并为参数传递空字符串，生成的实例中的name属性总有初始"[Untitled]"：

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}
//AutomaticallyNamedDocument用一个非可失败构造器init(name:)重写了父类的可失败构造器init?(name:)。因为子类用另一种方式处理了空字符串的情况，所以不再需要一个可失败构造器，因此子类用一个非可失败构造器代替了父类的可失败构造器。

//你可以在子类的非可失败构造器中使用强制解包来调用父类的可失败构造器。比如，下面的UntitledDocument子类的name属性的值总是"[Untitled]"，它在构造过程中使用了父类的可失败构造器init?(name:)：

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}
//在这个例子中，如果在调用父类的可失败构造器init?(name:)时传入的是空字符串，那么强制解包操作会引发运行时错误。不过，因为这里是通过非空的字符串常量来调用它，所以并不会发生运行时错误。




//可失败构造器 init!
//通常来说我们通过在init关键字后添加问号的方式（init?）来定义一个可失败构造器，但你也可以通过在init后面添加惊叹号的方式来定义一个可失败构造器（init!），该可失败构造器将会构建一个对应类型的隐式解包可选类型的对象。
//你可以在init?中代理到init!，反之亦然。你也可以用init?重写init!，反之亦然。你还可以用init代理到init!，不过，一旦init!构造失败，则会触发一个断言。


//必要构造器
//在类的构造器前添加required修饰符表明所有该类的子类都必须实现该构造器：
class SomeClass {
    required init() {
        // 构造器的实现代码
    }
}
//在子类重写父类的必要构造器时，必须在子类的构造器前也添加required修饰符，表明该构造器要求也应用于继承链后面的子类。在重写父类中必要的指定构造器时，不需要添加override修饰符：

class SomeSubclass: SomeClass {
    required init() {
        // 构造器的实现代码
    }
}
//注意
//如果子类继承的构造器能满足必要构造器的要求，则无须在子类中显式提供必要构造器的实现。





//通过闭包或函数设置属性的默认值
//如果某个存储型属性的默认值需要一些定制或设置，你可以使用闭包或全局函数为其提供定制的默认值。每当某个属性所在类型的新实例被创建时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性。
//
//这种类型的闭包或函数通常会创建一个跟属性类型相同的临时变量，然后修改它的值以满足预期的初始状态，最后返回这个临时变量，作为属性的默认值。
//下面介绍了如何用闭包为属性提供默认值：

//class SomeClass {
//    let someProperty: SomeType = {
//        // 在这个闭包中给 someProperty 创建一个默认值
//        // someValue 必须和 SomeType 类型相同
//        return someValue
//    }()
//}
//注意闭包结尾的大括号后面接了一对空的小括号。这用来告诉 Swift 立即执行此闭包。如果你忽略了这对括号，相当于将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
//注意
//如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的self属性，或者调用任何实例方法。

struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
let board = Checkerboard()
print(board.squareIsBlackAtRow(row:0, column: 1))
// 打印 "true"
print(board.squareIsBlackAtRow(row:7, column: 7))
// 打印 "false"
