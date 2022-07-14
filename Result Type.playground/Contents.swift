import UIKit



// 원래 에러가 발생하는 경우, 에러를 따로 외부로 던져서 처리했지만,
// 리턴 타입 자체를 Result Type으로 구현하면, 함수 실행의 성공과 실패의 정보를
// 함께 담아서 리턴할 수 있다.

// Result 타입은 열거형으로써
// - case success(연관값)
// - case failure(연관값)


// 원래의 에러 처리의 과정(3단계)

// 에러 정의

enum HeightError: Error {
    case maxHeight
    case minHeight
}

// throwing 함수

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


do {
    let _ = try checkingHeight(height: 200)
    print("놀이기구 타는 것 가능")
} catch {
    print("놀이기구 타는 것 불가능")
}


// 위에 에러처리를 Result타입을 활용해서 에러를 처리해 보면?

func resultTypeCheckingHeight(height: Int) -> Result<Bool, HeightError> {
    
    if height > 190 {
        return Result.failure(HeightError.maxHeight)
    } else if height < 130 {
        return Result.failure(HeightError.minHeight)
    } else {
        if height >= 160 {
            return Result.success(true)
        } else {
            return Result.success(false)
        }
    }
}

// 리턴값을 받고
let result = resultTypeCheckingHeight(height: 200)

//처리
switch result {
case  Result.success(let data):
    print("결과값은 \(data)입니다.")
case Result.failure(let error):
    print(error)
}



// Result타입에는 여러 메서드가 존재 함
// get()메서드는 결과값을 throwing함수처럼 변환가능한 메서드 (Success 밸류를 리턴 함)

do {
    let data = try result.get()
    print("결과값은 \(data)입니다.")
} catch {
    print(error)
}


// Result 타입을 왜 사용 할까?
// 성공/실패의 경우를 깔끔하게 처리가 가능한 타입이다!
