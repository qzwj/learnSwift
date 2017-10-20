//: Playground - noun: a place where people can play
// 集合
// 数组(Array),有序集合
// 集合(Set), 无序集合
// 字典(Dictionaries) 无序键值对
import UIKit


//数组(Arrays)
//数组使用有序列表存储同一类型的多个值。相同的值可以多次出现在一个数组的不同位置中
//创建一个空数据
var emptyArr1 = [Int]() // 更推荐第一种
let emptyArr2 = Array<Int>()
let emptyArr3: [Int] = []
print("emptyArr1's count is \(emptyArr1.count) and emptyArr2's count is \(emptyArr2.count) and emptyArr3's count is \(emptyArr3.count)")
emptyArr1.append(3); // 添加一个子元素
emptyArr1 = [] //有类型的数组可以直接这样清空
//创建一个带有默认值的数组
//Swift 中的Array类型还提供一个可以创建特定大小并且所有数据都被默认的构造方法。我们可以把准备加入新数组的数据项数量（count）和适当类型的初始值（repeating）传入数组构造函数
var threeArr = Array(repeating: 0.0, count: 3) // 这个函数没有默认的提示
var fourArr = Array(repeating: 2.2, count: 4)
var oneArr = Array(repeating: 1, count: 1)
//通过两个数组相加创建一个数组
var sevenArr = threeArr + fourArr // 只有类型相同才可以相加
//通过字面量创建一个数组
var strArr = ["abc", "lwj", "dqy"]
var strArr1: [String] = ["abc", "lwj", "dqy"]
//访问和修改数组
strArr.append("come on") //添加数据
strArr.isEmpty //判空
strArr.count //长度
strArr.contains("love") //包含
strArr[2] // 取值
strArr[0]="love" //修改值  不可以用下标访问的形式去在数组尾部添加新项。
strArr+=["1","2"]
strArr[4...5]=["1","3","1", "4", "5","6"] // 批量修改数据, 前面可以是一段范围, 后面的类型要一直, 数量没有限制
strArr.insert("forver", at: 1) // 在某个位置插入新元素
strArr.remove(at: strArr.count-1)
strArr.removeLast()
print(strArr)

// 数组的遍历
for item in strArr {
    print(item)
}
// 同时需要索引和值
for (index, value) in strArr.enumerated() { // enumerated()返回一个由每一个数据项索引值和数据值组成的元组
    print("index: \(index), value: \(value)")
}


// 集合
// 集合(Set)用来存储相同类型并且没有确定顺序的值。当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组。
//一个类型为了存储在集合中，该类型必须是可哈希化的--也就是说，该类型必须提供一个方法来计算它的哈希值。一个哈希值是Int类型的，相等的对象哈希值必须相同，比如a==b,因此必须a.hashValue == b.hashValue。
//Swift 的所有基本类型(比如String,Int,Double和Bool)默认都是可哈希化的，可以作为集合的值的类型或者字典的键的类型。没有关联值的枚举成员值(在枚举有讲述)默认也是可哈希化的。
//注意：
//你可以使用你自定义的类型作为集合的值的类型或者是字典的键的类型，但你需要使你的自定义类型符合 Swift 标准库中的Hashable协议。符合Hashable协议的类型需要提供一个类型为Int的可读属性hashValue。由类型的hashValue属性返回的值不需要在同一程序的不同执行周期或者不同程序之间保持相同。
//因为Hashable协议符合Equatable协议，所以遵循该协议的类型也必须提供一个"是否相等"运算符(==)的实现。这个Equatable协议要求任何符合==实现的实例间都是一种相等的关系。也就是说，对于a,b,c三个值来说，==的实现必须满足下面三种情况：
//a == a(自反性)
//a == b意味着b == a(对称性)
//a == b && b == c意味着a == c(传递性)
//集合类型语法
//Swift 中的Set类型被写为Set<Element>，这里的Element表示Set中允许存储的类型，和数组不同的是，集合没有等价的简化形式。
//创建和构造一个空的集合
var letters = Set<Character>() // 没有简写形式
var letters1: Set<Character> = []
print("letter's count is \(letters.count) and letters1's count is \(letters1.count)")
// 字面量初始化
var letters2: Set<Character> = ["i", "l", "o", "e"]
var letters3: Set = ["r", "e", "a", "l", "l", "ys"]
// 访问和修改
letters.insert("I") // 插入一个值
letters = [] // 清空,类型依然是原来的
letters.isEmpty
letters.insert("s")
letters.insert("e")
letters.remove("a") // 不存在移除的,返回nil
letters.contains("s") //包含
print(letters)
for val in letters {
    print(val)
}
//Swift 的Set类型没有确定的顺序，为了按照特定顺序来遍历一个Set中的值可以使用sorted()方法，它将返回一个有序数组，这个数组的元素排列顺序由操作符'<'对元素进行比较的结果来确定.
for val in letters.sorted() {
    print(val)
}






