import UIKit
import Darwin


protocol SomeProtocol {
    func playPiano()
}


struct Mystruct: SomeProtocol {
    func playPiano() {
        print("피아노를 칩니다.")
    }
}


class Myclass: SomeProtocol {
    
    func playPiano() {
        print("피아노를 칩니다.")
        
    }
}

// 클래스 단점

class Bird {
    var isFemale = true
    
    func layEgg() {
        if isFemale {
            print("새가 알을 낳는다")
        }
    }
    func fly() {
        print("새가 하늘로 날아간다.")
    }
}


class Eagle: Bird {
    func soar() {
        print("공중으로 치솟아 난다.")
    }
}


class Penguin: Bird {
    func swim() {
        print("헤엄친다.")
    }
}
// 이런경우 어쩔수 없이 펭귄은 날개됨 (상속으로 인해 모든 메서드 상속)

class Airplane: Bird {
    override func fly() {
        print("비행기가 엔진을 사용해서 날아간다.")
    }
}
// 이런경우 비행기가 알을 낳게됨 (위와 같음)


struct FlyingMuseum {
    func flyingDemo(flyingObject: Bird) {
        flyingObject.fly()
    }
}

let myEagle = Eagle()
myEagle.fly()
myEagle.layEgg()
myEagle.soar()

let myPenguin = Penguin()
myPenguin.layEgg()
myPenguin.swim()
myPenguin.fly()  // 이게 문제가됨 (펭귄이 난다)

let myPlane = Airplane()
myPlane.fly()
myPlane.layEgg()  // 이것도 문제가 됨 (비행기가 알을 낳음)

let museum = FlyingMuseum()
museum.flyingDemo(flyingObject: myEagle)
museum.flyingDemo(flyingObject: myPenguin)
museum.flyingDemo(flyingObject: myPlane)



protocol CanFly {
    func fly()
}


class Bird1 {
    var isFemale = true
    
    func layEgg() {
        if isFemale {
            print("새가 알을 낳는다.")
        }
    }
}

class Eagle1: Bird1, CanFly {
    func fly() {
        print("독수리가 하늘로 날아올라 간다.")
    }
    func soar() {
        print("공중으로 활공한다.")
    }
}

class Penguin1: Bird1 {
    func swim() {
        print("물 속을 헤엄칠 수 있다.")
    }
}

//구조체도 가능
struct Airplane1: CanFly {
    func fly() {
        print("비행기가 날아간다.")
    }
}


let myEagle1 = Eagle1()

myEagle1.layEgg()
myEagle1.fly()
myEagle1.soar()

let myPenguin1 = Penguin1()

myPenguin1.layEgg()
myPenguin1.swim()
//myPenguin1.fly()      // 이건 더이상 펭귄이 날지 않음

let myPlane1 = Airplane1()

myPlane1.fly()
//myPlane1.layEgg()     // 이것도 더이상 비행기가 알을 낳지 않음




//

protocol MyProtocol { }

class FamilyClass { }

class MyClass: FamilyClass, MyProtocol {  //프로토콜 보다 클래스 부터 작성

}

struct MyStruct: MyProtocol {
    
}

enum MyEnum: MyProtocol {
    
}


//

protocol RemoteMouse {
    var id: String { get }
    var name: String { get set }
    static var type: String { get set }
}

struct TV: RemoteMouse {
    var id: String = "456"
    var name: String = "삼성티비"
    static var type: String = "리모콘"
}

let myTV = TV()
myTV.id
myTV.name
TV.type


class SmartPhone: RemoteMouse {
    var id: String {
        return "777"
    }
    var name: String {
        get { "아이폰"}
        set { }
        }
    
    static var type: String = "리모콘"
    }


class Ipad: RemoteMouse {
    var id: String = "777"
    var name: String = "아이패드"
    
    static var type: String {
        get { "리모콘" }
        set { }
    }
}

//

protocol RandomNumber {
    static func reset() // class 키워드를 쓰면 재정의 허용
    func random() -> Int
}

class Number: RandomNumber {
    
    static func reset() {
        print("다시 셋팅")
    }
    func random() -> Int {
        return Int.random(in: 1...100)
    }
}


let n = Number()
n.random()
Number.reset()


//

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case on
    case off
    
    mutating func toggle() {
        switch self {
        case OnOffSwitch.off:
            self = .on
        case OnOffSwitch.on:
            self = .off
        }
    }
}
    
var s = OnOffSwitch.off
s.toggle()
s.toggle()

class BigSwitch: Togglable {
    var isON = false
    
    func toggle() {
        isON = isON ? false : true
    }
}

var big = BigSwitch()
print(big.isON)
big.toggle()
print(big.isON)



//

