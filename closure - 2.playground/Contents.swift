import UIKit

// 캡처 현상

// 함수 내에서 함수를 실행하고, 값을 리턴하는 일반적인 함수

func calculate(number: Int) -> Int {
    
    var sum = 0
    
    func square(num: Int) -> Int {
        sum += (num * num)
        return sum
    }
    
    let result = square(num: number)
    
    return result
}


calculate(number: 10)       //  100
calculate(number: 20)       //  400
calculate(number: 30)       //  900


// 일반적인 함수는 메모리 공간에 스택에서 처리되기 때문에 캡처 현상 x

// 변수를 캡처하는 함수(중첩 함수의 내부 함수)

func calculateFunc() -> ((Int) -> Int) {
    
    var sum = 0
    
    func square(num: Int) -> Int {
        sum += num * num
        return sum
    }
    
    return square
}

var squareFunc = calculateFunc()

// 이런식으로 함수를 변수에 할당하는 경우
// 힙(Heap) 메모리에 유지를 해야함, 함수라 하더라도 클로저 방식으로 동작

squareFunc(10)        //  100
squareFunc(20)        //  500
squareFunc(30)        //  1400




// 밸류(Value) 타입 캡처와 캡처리스트

// 클로저는 자신이 사용할 외부의 변수를 캡처함

var num = 1

let valueCaptureClosure = {
    print("밸류값 출력(캡처): \(num)")
}

num = 7
valueCaptureClosure()    // 몇을 출력? --> 7

num = 1
valueCaptureClosure()    // 몇을 출력? --> 1

// 밸류타입의 참조(메모리주소)를 캡처함
// 즉, 값 자체를 복사해서 가지고 있는 것이 아니고, num의 주소를 캡처해서 사용

num = 1
valueCaptureClosure()    // 몇을 출력? --> 1


// 캡처리스트에서 밸류(Value) 타입 캡처

let valueCaptureListClosure = { [num] in
    print("밸류값 출력(캡처리스트): \(num)")
}

num = 7
valueCaptureListClosure()   // 몇을 출력? --> 1

// 캡처리스트는 num의 주소를 캡처하는것이 아니고
// 캡처리스트 사용 당시에 num의 값 자체를 복사해서 가지고 계속 사용
// 사용 이유? -> 참조하는 값의 변경을 방지(외부적인 요인에 의한)



// 참조(Reference) 타입 캡처와 캡처리스트

class SomeClass {
    var num = 0
}

var x = SomeClass()
var y = SomeClass()

print("참조 초기값(시작값):", x.num, y.num)

let refTypeCapture = { [x] in
    print("참조 출력값(캡처리스트):", x.num, y.num)
}

// x는 (참조타입) 주소값 캡처, x를 직접참조로 가르킴 (클로저에서 인스턴스 x를 직접 찹조)
// y는 변수를 캡처해서, y변수를 가르킴(간접적으로 y도 동일)



// 강한 참조 사이클 문제의 해결
// 캡처리스트 + weak/unowned

var z = SomeClass()

let refTypeCapture1 = { [weak z] in
    print("참조 출력값(캡처리스트):", z?.num)
}

// weak은 unowned과 다르게 값이 없으면 nil이 되기 때문에 '?' 붙혀줘야함

refTypeCapture1()     // Optional(0)


let refTypeCapture2 = { [unowned z] in
    print("참조 출력값(캡처리스트):", z.num)
}

refTypeCapture2()     // 0


// 캡처리스트에서 바인딩도 가능

var s = SomeClass()

let captureBinding = { [z = s] in
    print("바인딩의 경우:", z.num)
}

// 내부에서 변수명 바꿔서 사용가능

let captureWeakBinding = { [weak z = s] in
    print("Weak 바인딩 경우:", z?.num)
}

captureBinding()
captureWeakBinding()
