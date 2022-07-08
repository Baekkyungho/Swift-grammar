import UIKit


protocol Aproto {    //실패가능 생성자
    init?(num: Int)
}


struct Astruct: Aproto {
    init(num: Int) {}
}

class Aclass: Aproto {
    required init?(num: Int) {}
}


// init? --> init, init?, init! 가능
// init --> init? 불가능 (범위문제)


//

protocol DataList {
    subscript(index: Int) -> Int { get }
}

struct DataStructure: DataList {
    subscript(index: Int) -> Int {
        get {
            return 0
        }
        set { }
    }
}

// get --> (get),(get,set) 다 가능
// get, set --> (get,set) 만 가능


//

protocol Certificate {
    func doSomething()
}


class Person {
   
}

extension Person: Certificate {
    func doSomething() {
        print("Do something")
    }
}

// 클래스 본체가 프로토콜을 채택해서 사용하는것 보다
// 확장에서 프로토콜을 채택해서 사용하는게 더 깔끔함


//

protocol Remote {
    func turnOn()
    func turnOff()
}

class TV: Remote {
    func turnOn() {
        print("TV켜기")
    }
    
    func turnOff() {
        print("TV끄기")
    }
}

struct SetTopBox: Remote {
    func turnOn() {
        print("셋톱박스켜기")
    }
    func turnOff() {
        print("셋톱박스끄기")
    }
    
    func doNetflix() {
        print("넷플릭스 보기")
    }
}

let tv = TV()
tv.turnOn()
tv.turnOff()

let sbox = SetTopBox()
sbox.turnOn()
sbox.turnOff()
sbox.doNetflix()


let electronic: [Remote] = [tv, sbox] // 프로토콜 타입 취급 장점

for item in electronic {
    item.turnOn()
}

func turnOnSomeElectronics(item: Remote) {
    item.turnOn()
}

turnOnSomeElectronics(item: tv)
turnOnSomeElectronics(item: sbox)


// is 연산자

tv is Remote
sbox is Remote

electronic[0] is TV
electronic[1] is SetTopBox

// as 연산자

let newBox = sbox as Remote
newBox.turnOn()
newBox.turnOff()

let sbox2: SetTopBox? = electronic[1] as? SetTopBox
sbox2?.doNetflix()



//



protocol Remote1 {
    func turnOn()
    func turnOff()
}

protocol AirConRemote1 {
    func Up()
    func Down()
}

protocol SuperRemoteProtocol1: Remote1, AirConRemote1 {
    
    func doSomething()
}

class HomePot: SuperRemoteProtocol1 {
    func turnOn() {}
    func turnOff() {}
    
    func Up() {}
    func Down() {}
    
    func doSomething() {}
}

// 프로토콜 끼리 채택, 다중 상속 가능

//


protocol SomeProtocol: AnyObject {
    func doSomething()
}


class Aclass1: SomeProtocol {
    func doSomething() {
        print("Do something")
    }
}

// AnyObject 타입은 클래스 전용 프로토콜이다. (구조체 채택 불가능!)

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person1: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("생일축하해, \(celebrator.name), 넌 이제 \(celebrator.age)살이 되었구나! ")
}

let birthdayPerson = Person1(name: "홍길동", age: 20)
wishHappyBirthday(to: birthdayPerson)

let whoIsThis: Named & Aged = birthdayPerson

//


@objc protocol Remote2 {
    @objc optional var isOn: Bool { get set }
    func turnOn()
    func turnOff()
    @objc optional func doNetflix()
}

class TV2: Remote2 {
    func turnOn() {}
    func turnOff() {}
    var isOn = false   // 안해도됨
    func doNetflix() {}   // 안해도됨
}

// 프로토콜 앞에는 @objc, 멤버 앞에는 @objc optional 모두 추가
// 앞에 붙힐시 강제하는 멤버가 아니라 선택적인 요구사항을 구현할때 사용


let tv2: TV2 = TV2()
print(tv2.isOn)











