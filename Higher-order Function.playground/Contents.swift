import UIKit
import Foundation

/**
- 고차원의 함수는
- 함수를 파라미터로 사용하거나, 함수실행의 결과를 함수로 리턴하는 함수
- Sequence, Collection 프로토콜을 따르는 컬렉션(배열, 딕셔너리, 세트 등)
 에 기본적으로 구현되어 있는 함수
 */


// (1)map 함수
// 기본 배열 등의 각 아이템을 새롭게 매핑해서 새로운 배열을 리턴하는 함수

let numbers = [1, 2, 3, 4, 5]

var newNumbers = numbers.map { (num) in
    return "숫자: \(num)"
}

newNumbers = numbers.map { "숫자: \($0)" }

print(newNumbers)


var alphabet = ["A", "B", "C", "D"]

var newAlphabet = alphabet.map { (name) -> String in
    return name + "'s good"
}


// (2)filter 함수
// 기존 배열 등의 각 아이템을 조건을 확인 후, 참을 만족하는 아이템을 걸러내서
// 새로운 배열을 리턴

let names = ["Apple", "Black", "Circle", "Dream", "Blue"]

var newNames = names.filter { (name) -> Bool in
    return name.contains("B")
}

print(newNames)

let array = [1, 2, 3, 4, 5, 6, 7, 8]

var newArray = array.filter { (num) in
    return num % 2 == 0
}

newArray = array.filter { $0 % 2 == 0 }

print(newArray)

newArray = array.filter { $0 % 2 == 0 }.filter { $0 < 5 }

print(newArray)


// (3)reduce 함수
// 기존 배열 등의 각 아이템을 결합해서 마지막 결과값을 리턴

var numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

var resultSum = numbersArray.reduce(0) { (sum, num) in
    return sum + num
}

print(resultSum)

resultSum = numbersArray.reduce(100) { $0 - $1 }

print(resultSum)



// 기타 고차함수
// forEach 함수
// 기존 배열등의 아이템을 활용해서 각 아이템별로 특정 작업을 실행
// map함수와 다른점? return값이 없음

let immutableArray = [1, 2, 3, 4, 5]

immutableArray.forEach { num in
    print(num)
}

immutableArray.forEach { print("숫자: \($0)")}


// compactMap 함수
// 기존 배열등의 아이템을 새롭게 매핑할때, 옵셔널 요소는 제거하고 새로운 배열 리턴

let StringArray: [String?] = ["A", nil, "B", nil, "C"]

var newStringArray = StringArray.compactMap { $0 }

print(newStringArray)


let aNumbers = [-2, -1, 0, 1, 2]

var positiveNumbers = aNumbers.compactMap { $0 >= 0 ? $0 : nil}

print(positiveNumbers)

// 사실 이런 경우는 filter 함수로 가능
// aNumbers.filter { $0 > 0 }


// flatMap 함수
// 중첩된 배열의 각 배열을 새롭게 매핑해서 내부 중첩된 배열을 제거하고 리턴

var nestedArray = [[1, 2, 3,], [4, 5, 6], [7, 8, 9]]

print(nestedArray.flatMap { $0 })
