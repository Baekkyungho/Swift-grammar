import UIKit
import Foundation


// 클로저 - 이름이 없는(익명) 함수


// 기본 함수 형태

func aFunction(str: String) -> String {
    return "Hello, \(str)"
}

// 클로저 형태

let _ = {(str: String) -> String in
    return "Hello, \(str)"
}


// 클로저는 생략도 가능

let aClosure1 = { (str: String) in
    return "Hello, \(str)"
}

let aClosure2: (String) -> String = { str in
    return "Hello, \(str)"
}         // 이렇게 타입추론이 되었을때


let aClosure3 = {
    print("This is a closure.")
}


let aClosure4 = {str in
    return str + "!"
}

//

func closureParamFunction(closure: () -> ()) {
    print("프린트 시작")
    closure()
}

func printSwiftFunction() {
    print("프린트 종료")
}

let printSwift = {() -> () in
    print("프린트 종료")
}

closureParamFunction(closure: printSwiftFunction)
closureParamFunction(closure: printSwift)

//파라미터가 함수면 이런식으로 넣기도 하였음

// 그런데 클로저를 사용하면

closureParamFunction(closure: { () -> () in
    print("프린트 종료 - 1")
    print("프린트 종료 - 2")
})

//이런식으로 함수를 설정한뒤 넣는게 아니라 즉석으로 클로저를 활용하여 함수 설정 가능

// 클로저를 파라미터로 받는 함수 정의
func closureCaseFunction(a: Int, b: Int, closure: (Int) -> Void) {
    let c = a + b
    closure(c)
}


// 함수를 실행할 때 (클로저 형태로 전달)

closureCaseFunction(a: 5, b: 2, closure: { (n) in
    print("출력할게요: \(n)")
})

closureCaseFunction(a: 5, b: 2) { (number) in
    print("출력할까요? \(number)")
}

closureCaseFunction(a: 5, b: 3) { (number) in
    print("출력")
    print("출력")
    print("출력")
    print("값: \(number)")
}

// 트레일링(Trailing) 클로저 - 후행 클로저 문법

func closureParamFunction1(closure: () -> Void) {
    print("프린트 시작")
    closure()
}


closureParamFunction1(closure: {
    print("프린트 종료")
})

closureParamFunction1(closure: ) {   // 소괄호 앞으로 가져오기
    print("프린트 종료")
}

closureParamFunction1 {   // 아규먼트 생략가능
    print("프린트 종료")
}

// 문법 최적화 하는 과정

// 함수정의

func performClosure(param: (String) -> Int) {
    param("Swift")
}

// 타입 추론

performClosure(param: {(str: String) -> Int in
    return str.count
})

performClosure(param: { str in
    return str.count
})


// 한줄인 경우 리턴 안적어도 됨

performClosure(param: { str in
    str.count
})

// 아규먼트 이름을 축약

performClosure(param: {
    $0.count
})

// 트레일링 클로저

performClosure(param: {
    $0.count
})

performClosure(){
    $0.count
}

performClosure { $0.count }

// 축약 형태로의 활용

let closureType1 = { (param) in
    return param % 2 == 0
}

let closureType2 = { $0 % 2 == 0}


let closureType3 = { (a: Int, b: Int) -> Int in
    return a * b
}

let closureType4: (Int, Int) -> Int = { (a, b) in
    return a * b
}

let closureType5: (Int, Int) -> Int = { $0 * $1 }
