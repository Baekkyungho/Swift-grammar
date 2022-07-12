import UIKit

// 멀티플 트레일링 클로저
// 여러개의 함수를 파라미터로 사용할 때

func multipleClosure(first: () -> (), second: () -> (), third: () -> ()) {
    first()
    second()
    third()
}

multipleClosure {
    print("1")
} second: {
    print("2")
} third: {
    print("3")
}

// 아규먼트 레이블을 생략하는 경우

func multipleClosure2(first: () -> (), _ second: () -> (), third: () -> ()) {
    first()
    second()
    third()
}

multipleClosure2 {
    print("1")
} _: {
    print("2")
} third: {
    print("3")
}


// @escaping 키워드
/**원칙적으로는 함수의 실행이 종료되면 파라미터로 쓰이는 클로저도 제거되는데, @escaping 키워드는 클로저를 제거하지 않고 함수에서 탈출시킴( 함수가 종료되어도 클로저가 존재하도록 함)**/

// 클로저를 단순실행 (지금까지 사용한 내용)

func performEscaping1(closure: () -> ()) {
    print("프린트 시작")
    closure()
}

performEscaping1 {
    print("프린트 중간")
    print("프린트 종료")
}

// 클로저를 외부변수에 저장 (@escaping 필요)

var aSavedFunction: () -> () = { print("출력") }

func performEscaping2(closure: @escaping () -> ()) {
    aSavedFunction = closure
}


//@autoclosure 키워드
// 파라미터가 없는 클로저만 가능

func someFunction(closure: @autoclosure () -> Bool) {
    if closure() {
        print("참입니다.")
    } else {
        print("거짓입니다.")
    }
}

var num = 1

someFunction(closure: num == 1)

// 일반적으로 클로저 형태로 써도 되지만 번거로울때 사용
// 번거로움을 해결해주지만, 실제 코드가 명확해 보이지 않을 수 있으므로 사용 지양



