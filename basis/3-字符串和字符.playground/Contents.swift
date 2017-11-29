//: Playground - noun: a place where people can play
// 字符串和字符
import UIKit

// 普通的字符串
//字符串是值类型
//Swift 的String类型是值类型。 如果您创建了一个新的字符串，那么当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝。 任何情况下，都会对已有字符串值创建新副本，并对该新副本进行传递或赋值操作。 值类型在 结构体和枚举是值类型 中进行了详细描述。
//
//Swift 默认字符串拷贝的方式保证了在函数/方法中传递的是字符串的值。 很明显无论该值来自于哪里，都是您独自拥有的。 您可以确信传递的字符串不会被修改，除非你自己去修改它。
//
//在实际编译时，Swift 编译器会优化字符串的使用，使实际的复制只发生在绝对必要的情况下，这意味着您将字符串作为值类型的同时可以获得极高的性能
let str = "Hello world"

// 多行字符串(swift4新增特性, 更新完了xcode再来更新这一块)
// 加\表示续行, 就是保持格式好看,默认每一行都是有换行的, 如果我们在最后一行的字符串加了\, 就应该在下面再添加一行空行
// 最后一行的 """是对齐的方式, 里面的内容都不能超过
let ss = """
 \"""
 我的哥\
 哈哈
"""

// 字符串字面量的特殊字符
// 字符串字面量可以包含以下特殊字符:
// 转义字符\0(空字符)、\\(反斜线)、\t(水平制表符)、\n(换行符)、\r(回车符)、\"(双引号)、\'(单引号)。
// Unicode 标量. 写成\u{n}(u为小写)，其中n为任意一到八位十六进制数且可用的 Unicode 位码
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imageination is more important than knowledge" - Enistein 这里的"要加\转义
let dollarSign = "\u{24}"             // $, Unicode 标量 U+0024
let blackHeart = "\u{2665}"           // ♥, Unicode 标量 U+2665
let sparklingHeart = "\u{1F496}"      // 💖, Unicode 标量 U+1F496


// 初始化字符串
let str1 = ""
let str2 = String() // 两个字符串都为空
str1.isEmpty
str2.isEmpty

// 字符串的可变性
let str3 = "haha" // 不能再相加了let的常量字符串
var str4 = "lwj"
str4 += " ss"




// 字符 (一个定义的变量或者常量只能包含一个字符)
for c in "woaini" {
    print(c)
}
let char1: Character = "!"
let charArr: [Character] = ["5", "2", "0"]
let str5 = String(charArr)

// 字符串拼接 
let str6 = str3 + str4
let str7 = str3.appending(str4) // 调用函数, 在str3的末尾添加str4

// 字符串插值
// 字符串插值是一种构建新字符串的方式，可以在其中包含常量、变量、字面量和表达式。字符串字面量和多行字符串字面量都可以使用字符串插值。 您插入的字符串字面量的每一项都在以反斜线为前缀的圆括号中：
//注意：
//插值字符串中写在括号中的表达式不能包含非转义反斜杠 (\)，并且不能包含回车或换行符。不过，插值字符串可以包含其他字面量。
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"



//Unicode
//Unicode是一个国际标准，用于文本的编码和表示。 它使您可以用标准格式表示来自任意语言几乎所有的字符，并能够对文本文件或网页这样的外部资源中的字符进行读写操作。 Swift 的String和Character类型是完全兼容 Unicode 标准的。
//Unicode 标量
//Swift 的String类型是基于 Unicode 标量 建立的。 Unicode 标量是对应字符或者修饰符的唯一的21位数字，例如U+0061表示小写的拉丁字母(LATIN SMALL LETTER A)("a")，U+1F425表示小鸡表情(FRONT-FACING BABY CHICK) ("🐥")。
//注意： Unicode 码位(code poing) 的范围是U+0000到U+D7FF或者U+E000到U+10FFFF。Unicode 标量不包括 Unicode 代理项(surrogate pair) 码位，其码位范围是U+D800到U+DFFF。
//注意不是所有的21位 Unicode 标量都代表一个字符，因为有一些标量是留作未来分配的。已经代表一个典型字符的标量都有自己的名字，例如上面例子中的LATIN SMALL LETTER A和FRONT-FACING BABY CHICK



//可扩展的字形群集
//
//每一个 Swift 的Character类型代表一个可扩展的字形群。 一个可扩展的字形群是一个或多个可生成人类可读的字符 Unicode 标量的有序排列。
//举个例子，字母é可以用单一的 Unicode 标量é(LATIN SMALL LETTER E WITH ACUTE, 或者U+00E9)来表示。然而一个标准的字母e(LATIN SMALL LETTER E或者U+0065) 加上一个急促重音(COMBINING ACTUE ACCENT)的标量(U+0301)，这样一对标量就表示了同样的字母é。 这个急促重音的标量形象的将e转换成了é。
//
//在这两种情况中，字母é代表了一个单一的 Swift 的Character值，同时代表了一个可扩展的字形群。 在第一种情况，这个字形群包含一个单一标量；而在第二种情况，它是包含两个标量的字形群：

let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e 后面加上  ́
// eAcute 是 é, combinedEAcute 是 é
//可扩展的字符群集是一个灵活的方法，用许多复杂的脚本字符表示单一的Character值。 例如，来自朝鲜语字母表的韩语音节能表示为组合或分解的有序排列。 在 Swift 都会表示为同一个单一的Character值：

let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
// precomposed 是 한, decomposed 是 한
//可拓展的字符群集可以使包围记号(例如COMBINING ENCLOSING CIRCLE或者U+20DD)的标量包围其他 Unicode 标量，作为一个单一的Character值：

let enclosedEAcute: Character = "\u{E9}\u{20DD}"
// enclosedEAcute 是 é⃝
//地域性指示符号的 Unicode 标量可以组合成一个单一的Character值，例如REGIONAL INDICATOR SYMBOL LETTER U(U+1F1FA)和REGIONAL INDICATOR SYMBOL LETTER S(U+1F1F8)：

let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
// regionalIndicatorForUS 是 🇺🇸

//计算字符数量
//例如，如果你用四个字符的单词cafe初始化一个新的字符串，然后添加一个COMBINING ACTUE ACCENT(U+0301)作为字符串的结尾。最终这个字符串的字符数量仍然是4，因为第四个字符是é，而不是e：
var word = "cafe"
print("the number of characters in \(word) is \(word.count)")
// 打印输出 "the number of characters in cafe is 4"

word += "\u{301}"    // 拼接一个重音, U+0301
print("the number of characters in \(word) is \(word.count)")
// 打印输出 "the number of characters in café is 4"
//注意：
//可扩展的字符群集可以组成一个或者多个 Unicode 标量。这意味着不同的字符以及相同字符的不同表示方式可能需要不同数量的内存空间来存储。所以 Swift 中的字符在一个字符串中并不一定占用相同的内存空间数量。因此在没有获取字符串的可扩展的字符群的范围时候，就不能计算出字符串的字符数量。如果您正在处理一个长字符串，需要注意count属性必须遍历全部的 Unicode 标量，来确定字符串的字符数量。
//另外需要注意的是通过count属性返回的字符数量并不总是与包含相同字符的NSString的length属性相同。NSString的length属性是利用 UTF-16 表示的十六位代码单元数字，而不是 Unicode 可扩展的字符群集。



//字符串索引
//每一个String值都有一个关联的索引(index)类型，String.Index，它对应着字符串中的每一个Character的位置。
//前面提到，不同的字符可能会占用不同数量的内存空间，所以要知道Character的确定位置，就必须从String开头遍历每一个 Unicode 标量直到结尾。因此，Swift 的字符串不能用整数(integer)做索引。
//使用startIndex属性可以获取一个String的第一个Character的索引。使用endIndex属性可以获取最后一个Character的后一个位置的索引。因此，endIndex属性不能作为一个字符串的有效下标。如果String是空串，startIndex和endIndex是相等的。
//通过调用 String 的 index(before:) 或 index(after:) 方法，可以立即得到前面或后面的一个索引。您还可以通过调用 index(_:offsetBy:) 方法来获取对应偏移量的索引，这种方式可以避免多次调用 index(before:) 或 index(after:) 方法。
let testStr = "Hello world"
testStr.startIndex.encodedOffset
testStr.endIndex.encodedOffset
let greeting = "Guten Tagk"
greeting[greeting.startIndex]
//greeting[greeting.endIndex] //报错,越界, 因为endIndex是最后一个字符的后一个index
greeting[greeting.index(after: greeting.startIndex)]
greeting[greeting.index(before: greeting.endIndex)]
let index = greeting.index(greeting.startIndex, offsetBy: 2)
greeting[index]
//使用 indices 属性会创建一个包含全部索引的范围(Range)，用来在一个字符串中访问单个字符
for ee in greeting.indices {
    print("\(greeting[ee])", terminator: " ")
}
//注意：您可以使用 startIndex 和 endIndex 属性或者 index(before:) 、index(after:) 和 index(_:offsetBy:) 方法在任意一个确认的并遵循 Collection 协议的类型里面，如上文所示是使用在 String 中，您也可以使用在 Array、Dictionary 和 Set中。


// 插入和删除
var welcome = "hello"
// 插入一个字符
welcome.insert("!", at: welcome.startIndex)
welcome.insert("s", at: welcome.index(before: welcome.endIndex))
// 插入一个字符串
welcome.insert(contentsOf: " world", at: welcome.endIndex)
// 删除一个字符
let c1 = welcome.remove(at: welcome.index(welcome.startIndex, offsetBy: 5))
// 删除一个字符串
let range = welcome.index(welcome.startIndex, offsetBy: 5)..<welcome.endIndex
welcome.removeSubrange(range)
//注意： 您可以使用 insert(_:at:)、insert(contentsOf:at:)、remove(at:) 和 removeSubrange(_:) 方法在任意一个确认的并遵循 RangeReplaceableCollection 协议的类型里面，如上文所示是使用在 String 中，您也可以使用在 Array、Dictionary 和 Set 中。


// 子字符串
//当你从字符串中获取一个子字符串 —— 例如，使用下标或者 prefix(_:) 之类的方法 —— 就可以得到一个 SubString 的实例，而非另外一个 String。Swift 里的 SubString 绝大部分函数都跟 String 一样，意味着你可以使用同样的方式去操作 SubString 和 String。然而，跟 String 不同的是，你只有在短时间内需要操作字符串时，才会使用 SubString。当你需要长时间保存结果时，就把 SubString 转化为 String 的实例
//就像 String，每一个 SubString 都会在内存里保存字符集。而 String 和 SubString 的区别在于性能优化上，SubString 可以重用原 String 的内存空间，或者另一个 SubString 的内存空间（String 也有同样的优化，但如果两个 String 共享内存的话，它们就会相等）。这一优化意味着你在修改 String 和 SubString 之前都不需要消耗性能去复制内存。就像前面说的那样，SubString 不适合长期存储 —— 因为它重用了原 String 的内存空间，原 String 的内存空间必须保留直到它的 SubString 不再被使用为止。
//上面的例子，wo 是一个 String，意味着它在内存里有一片空间保存字符集。而由于 subStr 是 wo 的 SubString，它重用了 wo 的内存空间。相反，newStr 是一个 String —— 它是使用 SubString 创建的，拥有一片自己的内存空间。
let wo = "hello,world"
let i = wo.index(of: ",") ?? greeting.endIndex
let subStr = wo[..<i] // 子字符串 String.SebSequence
let newStr = String(subStr)


// 比较字符串
//字符串/字符相等
//字符串/字符可以用等于操作符(==)和不等于操作符(!=)，详细描述在比较运算符：

let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("These two strings are considered equal")
}
// 打印输出 "These two strings are considered equal"
//如果两个字符串（或者两个字符）的可扩展的字形群集是标准相等的，那就认为它们是相等的。在这个情况下，即使可扩展的字形群集是有不同的 Unicode 标量构成的，只要它们有同样的语言意义和外观，就认为它们标准相等。

//例如，LATIN SMALL LETTER E WITH ACUTE(U+00E9)就是标准相等于LATIN SMALL LETTER E(U+0065)后面加上COMBINING ACUTE ACCENT(U+0301)。这两个字符群集都是表示字符é的有效方式，所以它们被认为是标准相等的：

// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}
// 打印输出 "These two strings are considered equal"
//相反，英语中的LATIN CAPITAL LETTER A(U+0041，或者A)不等于俄语中的CYRILLIC CAPITAL LETTER A(U+0410，或者A)。两个字符看着是一样的，但却有不同的语言意义：

let latinCapitalLetterA: Character = "\u{41}"

let cyrillicCapitalLetterA: Character = "\u{0410}"

if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent")
}
// 打印 "These two characters are not equivalent"

//前缀/后缀相等
//通过调用字符串的hasPrefix(_:)/hasSuffix(_:)方法来检查字符串是否拥有特定前缀/后缀，两个方法均接收一个String类型的参数，并返回一个布尔值。
//下面的例子以一个字符串数组表示莎士比亚话剧《罗密欧与朱丽叶》中前两场的场景位置：
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
//您可以调用hasPrefix(_:)方法来计算话剧中第一幕的场景数：
var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")
// 打印输出 "There are 5 scenes in Act 1"
//相似地，您可以用hasSuffix(_:)方法来计算发生在不同地方的场景数：
var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
// 打印输出 "6 mansion scenes; 2 cell scenes"




