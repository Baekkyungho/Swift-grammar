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



