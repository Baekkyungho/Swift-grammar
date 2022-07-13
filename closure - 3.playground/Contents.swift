import UIKit



// 객체 내에서 클로저의 사용
// 클로저 내에서 객체의 속성 및 메서드에 접근시에는 "self키워드"를 반드시 사용해야함

class Dog {
    var name = "초코"
    
    func doSomething() {
        DispatchQueue.global().async {
            print("나의 이름은 \(self.name)입니다.")
        }
    }
}

// doSomething 안에있는 클로저는 오랫동안 저장할 필요가 있음
// 새로운 스택을 만들어서 실행하기 때문

var choco = Dog()
choco.doSomething()

// 클로저가 choco인스턴스에 강한 참조는 하지만 (RC + 1)
// 실제 강한 참조 사이클을 일으키진 않음


// 클로저의 강한 참조 해결: 캡처 리스트 + 약한/비소유 참조 선언

// 클로저를 객체 내에서 사용할때는 대부분 weak과 함께 사용한다고 보면 됨

class Person {
    let name = "홍길동"
    
    func sayMyName() {
        print("나의 이름은 \(name)입니다.")
    }
    
    func sayMyName1() {
        DispatchQueue.global().async {
            print("나의 이름은 \(self.name)입니다.")
        }
    }
    
    func sayMyName2() {
        DispatchQueue.global().async { [weak self] in
            print("나의 이름은 \(self?.name)입니다.")
        }
    }
    
    func sayMyName3() {
        DispatchQueue.global().async { [weak self] in
            guard let weakSelf = self else { return }
            print("나의 이름은 \(weakSelf.name)입니다.")
        }
    }
}


let person = Person()

person.sayMyName()
person.sayMyName1()
person.sayMyName2()

// 이런식으로 캡처리스트와 약한/비소유 참조 선언을 함으로 강한 참조 해결 가능



// (함수형 프로그래밍)이란?

// 먼저 명령형 프로그래밍
// 배열의 합을 구하는 문제

let numbers = [1, 2, 3]

var sum = 0

for i in numbers {
    sum += i
}

print(sum)

// 함수형에서 배열의 합을 구하는 문제는?

let newNumbers = [1, 2, 3]
var newSum = 0

newSum = newNumbers.reduce(0) { $0 + $1 }

print(newSum)

// 함수형 프로그래밍은 "사이드 이펙트가 없도록" 선언형으로 프로그래밍 하는 것

// 산에 올라가는 방법
// 1. 산을 걸어서 올라가는 방법 (명령형 프로그래밍)
// 2. 헬리콥터에서 정상에서 내리는 방법 (함수형 프로그래밍)


// 배열에서 홀수만 제곱해서 그 숫자를 다 더한 값은?

var numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

var newResult = numbersArray.filter { $0 % 2 != 0}
                            .map { $0 * $0 }
                            .reduce(0) { $0 + $1 }

print(newResult)
