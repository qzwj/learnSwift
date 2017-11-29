//: Playground - noun: a place where people can play
// 类型转换
import UIKit

//类型转换 可以判断实例的类型，也可以将实例看做是其父类或者子类的实例。
//类型转换在 Swift 中使用 is 和 as 操作符实现。这两个操作符提供了一种简单达意的方式去检查值的类型或者转换它的类型。
//你也可以用它来检查一个类型是否实现了某个协议，就像在检验协议的一致性部分讲述的一样。


//定义一个类层次作为例子
//你可以将类型转换用在类和子类的层次结构上，检查特定类实例的类型并且转换这个类实例的类型成为这个层次结构中的其他类型。下面的三个代码段定义了一个类层次和一个包含了这些类实例的数组，作为类型转换的例子。
//第一个代码片段定义了一个新的基类 MediaItem。这个类为任何出现在数字媒体库的媒体项提供基础功能。特别的，它声明了一个 String 类型的 name 属性，和一个 init(name:) 初始化器。（假定所有的媒体项都有个名称。）

class MediaItem {
    var name: String
    init(name: String){
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String){
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let libary = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
//libary.append(MediaItem(name: "lwj"))
//在幕后 library 里存储的媒体项依然是 Movie 和 Song 类型的。但是，若你迭代它，依次取出的实例会是 MediaItem 类型的，而不是 Movie 和 Song 类型。为了让它们作为原本的类型工作，你需要检查它们的类型或者向下转换它们到其它类型，就像下面描述的一样。


//检查类型
//用类型检查操作符（is）来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回 true，否则返回 false。
//下面的例子定义了两个变量，movieCount 和 songCount，用来计算数组 library 中 Movie 和 Song 类型的实例数量：
var movieCount = 0
var songCount = 0
for item in libary {
    if item is Movie {
        movieCount+=1
    }else if item is Song {
        songCount+=1
    }
}
print("movieCount = \(movieCount), songCount = \(songCount)")


//向下转型
//某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符（as? 或 as!）。
//    因为向下转型可能会失败，类型转型操作符带有两种不同形式。条件形式as? 返回一个你试图向下转成的类型的可选值。强制形式 as! 把试图向下转型和强制解包转换结果结合为一个操作。
//        当你不确定向下转型可以成功时，用类型转换的条件形式（as?）。条件形式的类型转换总是返回一个可选值，并且若下转是不可能的，可选值将是 nil。这使你能够检查向下转型是否成功。
//只有你可以确定向下转型一定会成功时，才使用强制形式（as!）。当你试图向下转型为一个不正确的类型时，强制形式的类型转换会触发一个运行时错误。
//下面的例子，迭代了 library 里的每一个 MediaItem，并打印出适当的描述。要这样做，item 需要真正作为 Movie 或 Song 的类型来使用，而不仅仅是作为 MediaItem。为了能够在描述中使用 Movie 或 Song 的 director 或 artist 属性，这是必要的。
//在这个示例中，数组中的每一个 item 可能是 Movie 或 Song。事前你不知道每个 item 的真实类型，所以这里使用条件形式的类型转换（as?）去检查循环里的每次下转：

for item in libary {
    if let movie = item as? Movie { // as?是转化为可选类型, as!直接强转, 可能会发生运行时错误
        print("Movie: \(movie.name), dir: \(movie.director)")
    }else if let song = item as? Song {
        print("Song: \(song.name), dir: \(song.artist)")
    }
}
//注意
//转换没有真的改变实例或它的值。根本的实例保持不变；只是简单地把它作为它被转换成的类型来使用。



//Any 和 AnyObject 的类型转换
//Swift 为不确定类型提供了两种特殊的类型别名：
//Any 可以表示任何类型，包括函数类型。
//AnyObject 可以表示任何类类型的实例。
//只有当你确实需要它们的行为和功能时才使用 Any 和 AnyObject。在你的代码里使用你期望的明确类型总是更好的。
//这里有个示例，使用 Any 类型来和混合的不同类型一起工作，包括函数类型和非类类型。它创建了一个可以存储 Any 类型的数组 things：
var things = [Any]() //任意类型的数组
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.1415926)
things.append("hello, dqy")
things.append((3.0, 3.1))
things.append(Movie(name: "sss", director: "sfa"))
things.append({(name: String) -> String in "hello, girl"})
//let ss = {(name: String) -> String in return ""} //闭包

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}
//things 数组包含两个 Int 值，两个 Double 值，一个 String 值，一个元组 (Double, Double)，一个Movie实例“Ghostbusters”，以及一个接受 String 值并返回另一个 String 值的闭包表达式。
//你可以在 switch 表达式的 case 中使用 is 和 as 操作符来找出只知道是 Any 或 AnyObject 类型的常量或变量的具体类型。下面的示例迭代 things 数组中的每一项，并用 switch 语句查找每一项的类型。有几个 switch 语句的 case 绑定它们匹配到的值到一个指定类型的常量，从而可以打印这些值：
//注意
//Any类型可以表示所有类型的值，包括可选类型。Swift 会在你用Any类型来表示一个可选值的时候，给你一个警告。如果你确实想使用Any类型来承载可选值，你可以使用as操作符显式转换为Any，如下所示：
let optionalNumber: Int? = 3
things.append(optionalNumber)        // 警告
things.append(optionalNumber as Any) // 没有警告

