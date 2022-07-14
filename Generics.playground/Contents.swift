import UIKit


// 제네릭(Generics) 문법은 왜 필요 할까?

var num1 = 10
var num2 = 20

// 두 숫자를 스왑하는 함수의 정의

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}


// 위에서 정의한 함수의 실행
swapTwoInts(&num1, &num2)

print(num1)
print(num2)

// 그런데 만약, Double을 교환하고 싶다면?, String을 교환하고 싶다면?

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let tempA = a
    a = b
    b = tempA
}

func swapTwoString(_ a: inout String, _ b: inout String) {
    let tempA = a
    a = b
    b = tempA
}

// 이런식으로 제네릭이 없다면 함수(클래스, 구조체, 열거형 등) 타입마다 모든경우를 다 정의하야 해서 개발자의 할일이 늘어나게 된다.

// 제네릭은 타입에 관계없이, 하나의 정의(구현)로 모든 타입(자료형)을 처리할 수 있는 문법


// 제네릭 함수를 정의하는 방법! (여기선 T를 썼지만 아무 문자나 가능함!)

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

var string1 = "hello"
var string2 = "world"

// 제네릭으로 정의한 함수 사용해보기

swapTwoValues(&string1, &string2)
print(string1)
print(string2)

// 배열을 출력하는 예제

let numbers = [2, 3, 4, 5]
let scores = [3.1, 4.5, 6.3]
let people = ["Jobs", "Cook", "Musk"]

func printArray<T>(array: [T]) {
    for element in array {
        print(element)
    }
}

printArray(array: numbers)
printArray(array: scores)
printArray(array: people)


// 클래스, 구조체, 열거형에도 제네릭 타입 가능

struct Member {
    var members: [String] = []
}

struct GenericMember<T> {
    var members: [T] = []
}

var member1 = GenericMember(members: ["Jobs", "Cook", "Musk"])
var member2 = GenericMember(members: [1, 2, 3])

class GridPoint<A> {
    var x: A
    var y: A
    
    init(x: A, y: A) {
        self.x = x
        self.y = y
    }
}

let aPoint = GridPoint(x: 10, y: 20)
let bPoint = GridPoint(x: 10.4, y: 20.5)


// 열거형에서는 '연관값'을 가질때 제네릭으로 정의가능

enum Pet<T> {
    case dog
    case cat
    case etc(T)
}

let animal = Pet.etc("고슴도치")



// 제네릭 구조체의 확장

struct Coordinates<T> {
    var x: T
    var y: T
}

extension Coordinates {       // Coordinates<T> (X)
    func getPlace() -> (T, T) {
        return (x, y)
    }
}

let place = Coordinates(x: 5, y: 5)
print(place.getPlace())


// where절도 추가가 가능

extension Coordinates where T == Int {
    func getIntArray() -> [T] {
        return [x, y]
    }
}

let place2 = Coordinates(x: 3, y: 6)
place2.getIntArray()


// 제네릭에서 타입을 제약하는것도 가능함

func findIndex<T:Equatable>(item: T, array: [T]) -> Int? {
    for(index, value) in array.enumerated() {
        if item == value {
            return index
        }
    }
    return nil
}

let aNumber = 5
let someArray = [3, 4, 5, 6, 7]

if let index = findIndex(item: aNumber, array: someArray) {
    print("밸류값과 같은 배열의 인덱스: \(index)")
}

// 클래스 제약의 예시

class Person {}
class Student: Person {}

let person = Person()
let student = Student()

func personClassOnly<T: Person>(array: [T]) {
    // 함수의 내용
}

personClassOnly(array: [person, person])
personClassOnly(array: [student, student])



// 프로토콜을 제네릭 방식으로 선언하려면
// 연관타입(Assiciated Types)으로 선언해야함
// <T> ===> associatetype T

protocol RemoteControl {
    associatedtype T     // 연관형식은 대문자로 시작해야함
    func changeChannel(to: T)
    func alert() -> T?
}


// 연관형식이 선언된 프로토콜을 채용한 타입은 typealias로 실제 형식을 표시해야함

struct TV: RemoteControl {
    typealias T = Int
    
    func changeChannel(to: Int) {
        print("TV 채널바꿈: \(to)")
    }
    
    func alert() -> Int? {
        return 1
    }
}

class Aircon: RemoteControl {
    
    func changeChannel(to: String) {
        print("Aircon 온도 바꿈: \(to)")
    }
    
    func alert() -> String? {
        return "1"
    }
}


// 연관 형식에 제약을 추가
protocol RemoteControl2 {
    associatedtype Element: Equatable
    func changeChannel(to: Element)
    func alert() -> Element?
}
