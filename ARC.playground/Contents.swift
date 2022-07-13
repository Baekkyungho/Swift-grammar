import UIKit


// ARC를 통한 메모리 관리

class Dog {
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}

var choco: Dog? = Dog(name: "초코", weight: 15.0)  // RC: 1
var bori: Dog? = Dog(name: "보리", weight: 10.0)  // RC: 1

choco = nil  // RC: 0
bori = nil  // RC: 0

var dog1: Dog?
var dog2: Dog?
var dog3: Dog?

dog1 = Dog(name: "멍멍이", weight: 7.0)  // RC: 1
dog2 = dog1                            // RC: 2
dog3 = dog1                            // RC: 3

dog3 = nil                             // RC: 2
dog2 = nil                             // RC: 1
dog1 = nil                             // RC: 0
// 메모리 해체



// 메모리 누수(Memory Leak) 현상

class Cat {
    var name: String
    var owner: Person?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}

class Person {
    var name: String
    var pet: Cat?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}

var star: Cat? = Cat(name: "별이")
var gildong: Person? = Person(name: "홍길동")

star?.owner = gildong
gildong?.pet = star

// 강한 참조 사이클이 일어남

star = nil
gildong = nil

//이런식으로 변수 참조에 nil을 할당해도 메모리 해제가 되지않는
//메모리 누수의 상황이 발생


//메모리 누수 현상의 해결
// 1. 약한 참조 (Weak Reference)

class Cat1 {
    var name: String
    weak var owner: Person1?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}

class Person1 {
    var name: String
    weak var pet: Cat1?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}

var star1: Cat1? = Cat1(name: "별이")
var gildong1: Person1? = Person1(name: "홍길동")

// 강한 참조 사이클이 일어나지 않음
star1?.owner = gildong1
gildong1?.pet = star1


// 메모리 해제가 잘됨(이 경우는 한쪽만 weak으로 선언해도 상관없음)
star1 = nil
gildong1 = nil

// 약한 참조의 경우, 참조하고 있던 인스턴스가 사라지면, nil로 초기화 되어있음!


// 2. 비소유 참조 (Unowned Reference)

class Cat2 {
    var name: String
    unowned var owner: Person2?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}

class Person2 {
    var name: String
    unowned var pet: Cat2?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}

var star2: Cat2? = Cat2(name: "별이2")
var gildong2: Person2? = Person2(name: "홍길동2")

// 강한 참조 사이클이 일어나지 않음
star2?.owner = gildong2
gildong2?.pet = star2


// 메모리 해제가 잘됨 ( 이 경우도 한쪽만 unowned로 선언해도 괜찮음)
star2 = nil
gildong2 = nil

// 비소유 참조의 경우, 참조하고 있던 인스턴스가 사라지면, nil로 초기화 안됨
// weak과 다르게 인스턴스가 사라지면 에러가 발생함!
