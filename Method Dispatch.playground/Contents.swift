import UIKit


// 직접 디스패치 Direct Dispatch (static)

struct MyStruct {
    func method1() { print("Struct - Direct method1") }
    func method2() { print("Struct - Direct method2") }
}


// 테이블 디스패치 Table Dispatch (동적 디스패치)

class FirstClass {
    func method1() {print("Class - Table method1") }
    func method2() {print("Class - Table method2") }
}

//func method1() {print("Class - Table method1") }
//func method2() {print("Class - Table method2") }
//이렇게 테이블을 만듬 (데이터영역)

// 자식클래스에서는 테이블을 따로 보유

Class SecondClass: FirstClass {
    override func method2() { print("Class - Table method2-2") }
    func method3() { print("Class - Table method3") }
}

//func method1() {print("Class - Table method1") }
//func method2() {print("Class - Table method2-2") }
//func method3() { print("Class - Table method3") }
//자식클래스에는 이렇게 테이블을 만듬


// 메세지 디스패치 Message Dispatch (메세지 디스패치)
// 예전 Objective-C 에서 사용하던 방식

class ParentClass {
    @objc dynamic func method1() { print("Class - Message method1") }
    @objc dynamic func method2() { print("Class - Message method2") }
}

//func method1() { print("Class - Message method1") }
//func method2() { print("Class - Message method2") }
//이렇게 보유


//자식클래서에서는

class ChildClass: ParentClass {
    @objc dynamic override func method2() { print("Class - Message method 2-2")
}
    @objc dynamic func method3() { print("Class - Message method 3") }
}
 
//super class             <-- 상위 클래스를 가르킴
//func method2() { print("Class - Message method2-2") }   // 재정의한 메서드는 다시 주소가짐
//func method2() { print("Class - Message method3") }



//프로토콜 타입에서는 Table Dispatch 안에 있는 Witness Table 사용


protocol MyProtocol {
    func method1()   // 요구사항 - Witness Table
    func method2()   // 요구사항 - Witness Table
}

extension MyProtocol {
    func method1() { print("Protocol - Witness Table method1") }
    func method2() { print("Protocol - Witness Table method2") }
    
    func anotherMethod() {  // 필수 요구사항은 아니므로 이건 Direct Dispatch
        print("Protocol Extension - Direct method")
    }
}


// 클래스 타입에서는 Table Dispatch 안에 있는 virtual Table 사용

class FirstClass: Myprotocol {
    func method1() { print("Class - Virtual Table method1") }
    func method2() { print("Class - Virtual Table method2") }
    func anotherMethod() { print("Class - Virtual Table method3") }
}


//func method1() { print("Class - Virtual Table method1") }
//func method2() { print("Class - Virtual Table method2") }
//func anotherMethod() { print("Class - Virtual Table method3") }
//Virtual Table (클래스에서)

