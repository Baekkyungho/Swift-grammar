import UIKit


// 접근 제어(Access Control)이 필요한 이유?
// 코드의 세부 구현 내용을 숨기는 것이 가능하도록 만드는 개념(은닉화가 가능해짐)


class SomeClass {
    private var name = "이름"
    
    func nameChange(name: String) {
        if name == "길동" {
            return
        }
        self.name = name
    }
}

let object1 = SomeClass()
//object1.name                       // 접근불가
//object1.name = "홍길동"              // 접근불가

// 이름을 바꾸려면 특정 메서드로 실행만 가능
object1.nameChange(name: "홍길동")


// 스위프트의 5가지 접근 수준

/**===================================================================
 접근 수준(Access Levels)
 - 1) open        - 다른 모듈에서도 접근가능 / 상속 및 재정의도 가능 (제한 낮음)
 - 2) public      - 다른 모듈에서도 접근가능(상속/재정의불가)
 - 3) internal    - 같은 모듈 내에서만 접근가능(디폴트)
 - 4) fileprivate - 같은 파일 내에서만 접근가능
 - 5) private     - 같은 scope내에서만 접근가능                (제한 높음)
 
 - 모듈(module): 프레임워크, 라이브러리, 앱 등 import해서 사용할 수 있는 외부의 코드
 ====================================================================**/

// 클래스는 open이 가장 넓고(상속, 재정의와 관계)
// 구조체는 public이 가장 넓음(상속이 없기 때문)

// 타입은 타입을 사용하는 속성이나, 메서드보다 높은 수준으로 선언되어야함


// 변수(속성)
var some: String = "접근가능" // some은 internal, String은 public 수준 기본 정의 되어있음

// 함수(메서드)
internal func someFunction(a: Int) -> Bool {
    print(a)             // Int 타입
    print("hello")       // String 타입
    return true          // Bool 타입
}

// 함수에서는 파라미터, 리턴 타입이 더 낮은 접근 수준을 가질수 없음

// 실제 프로젝트에서 많이 사용하는 관습적인 패턴이 존재함
// 속성(변수)를 선언시 private로 외부에 감추려는 속성은 _(언더바)를 사용해서 이름 지음

class SomeOtherClass {
    private var _name = "이름"       // 쓰기 - private
    
    var name: String {              // 읽기 - internal
        return _name
    }
}

// 바로 위 함수는 쓰기는 불가능하고 읽기만 가능한데 다른방식으로 표현할 수 있다.

class SomeAnotherClass {
    private(set) var name = "이름"  // 읽기 internal, 쓰기 private
}


// 타입의 내부 멤버는 타입 자체의 접근 수준을 넘을 수 없음
// 타입이 internal이면 내부 멤버는 더 높은 수준을 가지고 있어도 최대 internal로 통일됨

// 타입 자체를 private로 선언하는 것은 의미가 없어서 fileprivate로 동작함

private class Aclass {
    open var Open = "Open"
    public var Public = "Public"
    internal var Internal = "Internal"
    fileprivate var Fileprivate = "FilePrivate"
    private var Private = "Private"
}

// 보이기엔 타입이 private이지만 fileprivate로 동작함

// 내부 멤버가 명시적 선언을 하지 않는다면, 접근 수준은 internal로 유지함!

open class SomeClass1 {
    var someProperty = "SomeInternal"  // interal임
}


// 상속에서 서브클래스는 상위클래스보다 높은 접근 수준 가질 수 없음
// 정의한 클래스의 상위 멤버의 접근 가능하면 (접근 수준 올려서) 재정의 가능함

public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {
        super.someMethod()
    }
}


// 확장에서는 본체와 동일하게 유지하고 본체 멤버는 기본적인 접근 가능함

public class Bclass {
    private var Private1 = "Private"
}

extension Bclass {
    func Private2() {
        Private1 = "접근가능함"
    }
}
