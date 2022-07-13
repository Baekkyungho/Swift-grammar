import UIKit

// 에러 처리 문법
// 1. 컴파일 타임 에러 ==> 스위프트 문법과 관련된 에러(컴파일러가 수정해야 한다고 알려줌)
// 2. 런타임 에러 ==> 크래시(앱이 강제로 종료)
// ==> 발생 가능한 에러를 미리 처리해 두면, 강제종료되지 않음(개발자가 처리해야만 하는 에러)


// 에러 처리의 과정(3단계)

// 1. 에러 정의 (어떤 에러가 발생할지 경우를 미리 정의)

enum HeightError: Error {
    case maxHeight
    case minHeight
}

// 2. 에러가 발생할 수 있는 함수에 대한 정의

func checkingHeight(height: Int) throws -> Bool {
    
    if height > 190 {
        throw HeightError.maxHeight
    } else if height < 130 {
        throw HeightError.minHeight
    } else {
        if height >= 160 {
            return true
        } else {
            return false
        }
    }
}

// 3. 에러가 발생할 수 있는 함수의 처리(함수의 실행)
// do-catch문으로 처리 (try도 사용)

do {
    let isChecked = try checkingHeight(height: 200)
    print("놀이기구 타는 것 가능: \(isChecked)")
} catch {
    print("놀이기구 타는 것 불가능")
}

// do블럭 - 함수를 통한 정상적인 처리의 경우 실행하는 블럭
// catch블럭 - 함수가 에러를 던졌을 경우의 처리 실행하는 블럭

// 에러를 처리하는 방법 - try / try? / try!

// 1) 에러 정식 처리 방법

do {
    let isChecked = try checkingHeight(height: 200)
    
    if isChecked {
        print("청룡열차 가능")
    } else {
        print("후룸라이드 가능")
    }
} catch {
    print("놀이기구 타는 것 불가능")
}

// 2) try?(옵셔널 트라이) ==> 옵셔널 타입으로 리턴
// 정상적인 경우 ==>(정상)리턴타입으로 리턴
// 에러가 발생하면 ==> nil 리턴

let ischecked: Bool? = try? checkingHeight(height: 200)

// 옵셔널 타입을 벗겨서 사용해야함

// 3) try!(Forced 트라이) ==> 에러가 날 수 없는 경우에만 사용 가능
// 정상정인 경우 ==> (정상)리턴타입으로 리턴
// 에러가 발생하면 ==> 런타임에러

let ischecked2: Bool = try! checkingHeight(height: 150)

// 에러가 발생할 수 없다고 확신이 있는 경우만 사용해야함


// 새 에러 정의
enum SomeError: Error {
    case aError
}

// 에러를 던지는 함수 정의 (무조건 에러를 던진다고 가정)
func throwingFunc() throws {
    throw SomeError.aError
}

// 에러의 처리
do {
    try throwingFunc()
} catch {
    print(error)
}


// 일반적인 함수로도 에러처리가 가능하기도 하다

func handleError() {
    do {
        try throwingFunc()
    } catch {
        print(error)
    }
}

handleError()



// 메서드와 생성자에도 throw키워드 적용 가능

// 에러정의

enum NameError: Error {
    case noName
}

// 생성자와 메서드에도 적용 가능

class Course {
    var name: String
    
    init(name:String) throws {
        if name == "" {
            throw NameError.noName
        } else {
            self.name = name
            print("수업을 올바르게 생성")
        }
    }
}

// 에러 처리 (생성자에 대한)

do {
    let _ = try Course(name: "스위프트")
} catch {
    print("이름이 없어 수업이 생성 실패하였습니다.")
}

// 생성자와 메서드의 재정의

class NewCourse: Course {
    override init(name: String) throws {
        try super.init(name: name)
    }
}



// 에러는 아니지만 Defer문에 대해
// defer문은 코드의 실행을 스코프가 종료되는 시점으로 연기시킴

func deferStatement1() {
    defer {
        print("나중에 실행하기")
    }
    
    print("먼저 실행하기")
}

deferStatement1()



func deferStatement2() {
    
    if true {
        print("먼저 실행하기")
    } else {
        return
    }
    
    defer {
        print("나중에 실행하기")
    }
}

deferStatement2()  // defer문이 호출되어야 디퍼문이 실행
// 여기서는 defer문이 실행되지 않음


// 등록한 역순으로 실행된다 (일반적으로는 하나의 디퍼문만 사용하는 것이 좋음)

func deferStatement3() {
    defer {
        print(1)
    }
    
    defer {
        print(2)
    }
    
    defer {
        print(3)
    }
}

deferStatement3()
